import 'package:chat_gui/app/components/interactive_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  late ScrollController scrollController;

  late TextEditingController inputController;
  final RxString inputText = ''.obs;

  late InteractiveDrawerController drawerController;
  var scrollOffsetPercent = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    drawerController = InteractiveDrawerController();

    inputController = TextEditingController();
    inputController.addListener(() {
      inputText.value = inputController.text;
    });

    scrollController = ScrollController();
    scrollController.addListener(() {
      scrollOffsetPercent.value =
          scrollController.offset / scrollController.position.maxScrollExtent;
    });
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    inputController.dispose();
  }
}
