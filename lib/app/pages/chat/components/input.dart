import 'package:chat_gui/app/pages/chat/controller.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';

class ChatInput extends GetView<ChatScreenController> {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FThemeBuildContext(context).theme;
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 10),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FButton.icon(onPress: () {}, child: Icon(FIcons.images, size: 22)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: FTextField(
                    controller: controller.inputController,
                    maxLines: 8,
                    minLines: 1,
                    hint: "Ask anything...",
                  ),
                ),
              ),
              FButton.icon(
                onPress: () {},
                style: FButtonStyle.primary(),
                child: Icon(FIcons.arrowUp, size: 22),
              ),
            ],
          ),
          Obx(() {
            final text = controller.inputText.value;
            if (text.length / 20 + text.split('\n').length <= 8) {
              return const SizedBox.shrink();
            }
            return Positioned(
              top: 0,
              right: 0,
              child: FButton.icon(
                onPress: () {},
                style: FButtonStyle.ghost(),
                child: Icon(FIcons.maximize2, size: 22),
              ),
            );
          }),
        ],
      ),
    );
  }
}
