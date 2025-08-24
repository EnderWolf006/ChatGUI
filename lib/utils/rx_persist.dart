// lib/utils/rx_persist.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

typedef FromJson<T> = T Function(dynamic raw);
typedef ToJson<T> = dynamic Function(T value);

/// Simple decoder registry to avoid passing fromJson everywhere.
/// Register once: PersistCodec.register<UserProfile>(UserProfile.fromJson);
/// OR PersistCodec.register<UserProfile>((raw) => UserProfile.fromJson(Map<String, dynamic>.from(raw as Map)));
class PersistCodec {
  static final Map<Type, Function> _decoders = {};

  /// Register decoder for type `T`.
  static void register<T>(FromJson<T> decoder) {
    _decoders[T] = decoder;
  }

  /// Get decoder for type `T` if registered.
  static FromJson<T>? decoder<T>() {
    final fn = _decoders[T];
    if (fn == null) return null;
    return (raw) => fn(raw) as T;
  }
}

class StorageManager {
  /// Init GetStorage once in main()
  static String container = 'GetStorage';
  static Future<void> initStorage([String container = 'GetStorage']) async {
    StorageManager.container = container;
    await GetStorage.init(container);
  }

  static GetStorage get box => GetStorage(container);
}

extension RxPersistX<T> on RxInterface<T> {
  /// Persist Rx value with load + throttle + debounce writes.
  ///
  /// - key: storage key
  /// - box: custom GetStorage
  /// - fromJson/toJson: optional codecs (fallback to model's toJson() if exists)
  /// - throttleDuration: periodic snapshot during rapid changes
  /// - debounceDuration: final save after changes stop
  void persist(
    String key, {
    GetStorage? box,
    FromJson<T>? fromJson,
    ToJson<T>? toJson,
    Duration throttleDuration = const Duration(milliseconds: 800),
    Duration debounceDuration = const Duration(milliseconds: 200),
  }) {
    final storage = box ?? StorageManager.box;

    // --- load once ---
    final raw = storage.read(key);
    if (raw != null) {
      try {
        final decoder = fromJson ?? PersistCodec.decoder<T>();
        if (decoder != null) {
          // set via dynamic to avoid RxInterface setter visibility issues
          (this as dynamic).value = decoder(raw);
        } else if (raw is T) {
          (this as dynamic).value = raw;
        } else {
          // If T is not primitive and no decoder is registered, skip silently
        }
      } catch (_) {
        // ignore malformed persisted data
      }
    }

    // --- writer ---
    void writeNow(T v) {
      dynamic data;
      try {
        if (toJson != null) {
          data = toJson(v);
        } else if (v is Map || v is List || v is String || v is num || v is bool) {
          data = v; // JSON-ready primitives
        } else {
          // try instance toJson() if available
          final dyn = v as dynamic;
          final maybeFn = dyn.toJson;
          if (maybeFn is Function) data = maybeFn();
        }
      } catch (_) {
        // swallow codec errors
      }
      if (data != null) storage.write(key, data);
    }

    // --- combine throttle + debounce ---
    T? latestValue;
    ever(this, (v) => latestValue = v);

    // Debounce: save after pause
    debounce(this, (v) => writeNow(v), time: debounceDuration);

    // Throttle: periodic snapshot during rapid changes
    interval(this, (_) {
      final v = latestValue;
      if (v != null) writeNow(v);
    }, time: throttleDuration);
  }
}
