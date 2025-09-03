import 'package:chat_gui/components/interactive_drawer.dart';
import 'package:chat_gui/pages/chat/components/content.dart';
import 'package:chat_gui/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:md_single_block_renderer/md_single_block_renderer.dart';

class ChatScreenController extends GetxController {
  late final ScrollController scrollController;

  late final TextEditingController inputController;
  final RxString inputText = ''.obs;

  late final TextEditingController searchInputController;
  final RxString searchInputText = ''.obs;

  late final InteractiveDrawerController drawerController;
  double scrollOffsetPercent = -1;

  final testMdBlocks = <Block>[].obs;

  final testStreamMd = ''.obs;

  @override
  void onInit() {
    super.onInit();

    markdownToBlocksAsync(testMd).then((List<Block> v) {
      testMdBlocks.value = List<List<Block>>.generate(100, (_) => v).expand((e) => e).toList();
      print(v);
    });

    drawerController = InteractiveDrawerController(
      initialValue: Get.find<AppStore>().tabletMode.value ? 1.0 : 0.0,
    );
    ever(Get.find<AppStore>().tabletMode, (isTablet) {
      if (drawerController.isOpen && !isTablet) {
        drawerController.close();
      }
      if (drawerController.isClosed && isTablet) {
        drawerController.open();
      }
    });

    inputController = TextEditingController();
    inputController.addListener(() {
      inputText.value = inputController.text;
    });

    searchInputController = TextEditingController();
    searchInputController.addListener(() {
      searchInputText.value = searchInputController.text;
    });

    scrollController = ScrollController();
    scrollController.addListener(() {
      if (!scrollController.hasClients ||
          !scrollController.position.hasContentDimensions) {
        return;
      }
      final max = scrollController.position.maxScrollExtent;
      if (max == 0) {
        scrollOffsetPercent = -1;
      } else {
        final current = scrollController.offset.clamp(0, max);
        final percent = max == 0 ? 0.0 : (current / max).clamp(0.0, 1.0);
        scrollOffsetPercent = percent;
      }
      update(['scrollBorder']);
    });
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    inputController.dispose();
  }
}
