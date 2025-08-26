import 'package:chat_gui/app/pages/chat/chat_screen.dart';
import 'package:chat_gui/app/pages/chat/controller.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.ChatScreen;

  static final routes = <GetPage<dynamic>>[
    GetPage(
      name: Routes.ChatScreen,
      page: () => ChatScreen(),
      transition: Transition.native,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ChatScreenController());
      }),
    ),
  ];
}
