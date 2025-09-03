import 'package:chat_gui/theme/app_theme.dart';
import 'package:chat_gui/utils/rx_persist.dart';
import 'package:chat_gui/utils/translation_service.dart';
import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'store/app_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Init persistent store
  await StorageManager.initStorage('ChatGUI');
  
  // Init translations
  await TranslationService.init();
  final store = await Get.putAsync<AppStore>(() async => AppStore().init());
  runApp(MainApp(store: store));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.store});
  final AppStore store;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'ChatGUI',
        themeMode: store.themeMode.value,
        debugShowCheckedModeBanner: false,
        theme: lightTheme.useSystemChineseFont(Theme.of(context).brightness),
        darkTheme: darkTheme.useSystemChineseFont(Theme.of(context).brightness),
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        translations: TranslationService(),
      ),
    );
  }
}
