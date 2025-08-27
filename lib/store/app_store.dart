import 'package:chat_gui/utils/rx_persist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStore extends GetxService {
  final themeMode = ThemeMode.system.obs;

  Future<AppStore> init() async {
    themeMode.persist(
      'themeMode',
      toJson: (mode) => mode.index,
      fromJson: (raw) {
        final index = raw as int;
        return ThemeMode.values[index];
      },
    );
    return this;
  }
}
