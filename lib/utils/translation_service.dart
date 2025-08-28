import 'dart:convert';
import 'package:chat_gui/constants/enums.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TranslationService extends Translations {
  static final Map<String, Map<String, String>> translations = {};

  @override
  Map<String, Map<String, String>> get keys => translations;

  static Future<void> init() async {
    final assets = SupportedLanguage.values
        .map((lang) {
          final str = '${lang.languageCode}_${lang.countryCode}';
          return MapEntry(str, 'assets/lang/$str.json');
        })
        .toList()
        .asMap()
        .map((_, e) => e);

    for (final entry in assets.entries) {
      translations[entry.key] = await _loadAndFlattenJson(entry.value);
    }
  }

  static Future<Map<String, String>> _loadAndFlattenJson(String path) async {
    try {
      final data = await rootBundle.loadString(path);
      final dynamic parsed = json.decode(data);
      final Map<String, String> flat = {};
      _flatten(parsed, '', flat);
      return flat;
    } catch (e) {
      return {};
    }
  }

  static void _flatten(dynamic node, String prefix, Map<String, String> out) {
    if (node is Map) {
      node.forEach((k, v) {
        final key = prefix.isEmpty ? '$k' : '$prefix.$k';
        _flatten(v, key, out);
      });
    } else if (node is List) {
      for (var i = 0; i < node.length; i++) {
        final key = prefix.isEmpty ? '$i' : '$prefix.$i';
        _flatten(node[i], key, out);
      }
    } else {
      if (prefix.isNotEmpty) {
        out[prefix] = node?.toString() ?? '';
      }
    }
  }
}
