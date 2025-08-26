import 'dart:ui';

import 'package:chat_gui/constants/enums.dart';
import 'package:chat_gui/utils/rx_persist.dart';
import 'package:get/get.dart';

class AppStore extends GetxService {
  final enableDarkMode = false.obs;
  final themeStrategy = ThemeStrategy.system.obs;
  final platformBrightness = PlatformDispatcher.instance.platformBrightness.obs;

  Future<AppStore> init() async {
    themeStrategy.persist('themeStrategy');

    // Listen to system brightness changes and update reactive value
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      platformBrightness.value = PlatformDispatcher.instance.platformBrightness;
    };

    onThemeNeedChange(null);
    everAll([themeStrategy, platformBrightness], onThemeNeedChange);

    return this;
  }

  void onThemeNeedChange(_) {
    if (themeStrategy.value == ThemeStrategy.alwaysDark) {
      enableDarkMode.value = true;
    } else if (themeStrategy.value == ThemeStrategy.alwaysLight) {
      enableDarkMode.value = false;
    } else {
      // followSystem
      enableDarkMode.value = platformBrightness.value == Brightness.dark;
    }
  }
}
