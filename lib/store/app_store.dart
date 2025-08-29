import 'package:chat_gui/utils/rx_persist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStore extends GetxService with WidgetsBindingObserver {
  // persist
  final themeMode = ThemeMode.system.obs;

  // memory
  var windowSize = Size.zero.obs;
  var tabletMode = false.obs;

  Future<AppStore> init() async {
    // persist
    themeMode.persist(
      'themeMode',
      toJson: (mode) => mode.index,
      fromJson: (raw) {
        final index = raw as int;
        return ThemeMode.values[index];
      },
    );

    // listener
    WidgetsBinding.instance.addObserver(this);
    updateWindowSize();
    // worker

    return this;
  }

  @override
  void didChangeMetrics() {
    updateWindowSize();
  }

  void updateWindowSize() {
    final view = PlatformDispatcher.instance.views.first;
    final size = view.physicalSize / view.devicePixelRatio;
    tabletMode.value = size.width > 600;
    windowSize.value = size;
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
