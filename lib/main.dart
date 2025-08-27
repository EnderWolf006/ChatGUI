import 'package:chat_gui/theme/app_theme.dart';
import 'package:chat_gui/utils/cxxxr.dart';
import 'package:chat_gui/utils/rx_persist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'store/app_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Init persistent store
  await StorageManager.initStorage('ChatGUI');
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
        title: 'Chat GUI',
        themeMode: store.themeMode.value,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
      ),
    );
  }
}
