import 'package:chat_gui/utils/rx_persist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:forui/forui.dart';

import 'app/routes/app_pages.dart';
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
        themeMode: store.enableDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        builder:
            (context, child) => FTheme(
              data: store.enableDarkMode.value ? FThemes.zinc.dark : FThemes.zinc.light,
              child: Material(
                color: FThemeBuildContext(context).theme.colors.background,
                child: child!,
              ),
            ),
      ),
    );
  }
}
