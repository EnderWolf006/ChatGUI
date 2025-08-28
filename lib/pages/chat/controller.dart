import 'package:chat_gui/components/interactive_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  late final ScrollController scrollController;

  late final TextEditingController inputController;
  final RxString inputText = ''.obs;

  late final InteractiveDrawerController drawerController;
  final scrollOffsetPercent = 0.0.obs;

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
