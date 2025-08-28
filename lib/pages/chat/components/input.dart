import 'package:chat_gui/pages/chat/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ChatInput extends GetView<ChatScreenController> {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 10),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(LucideIcons.images),
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.all(9),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Stack(
                  children: [
                    TextField(
                      controller: controller.inputController,
                      maxLines: 8,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'chat.input.placeholder'.tr,
                        contentPadding: EdgeInsets.only(
                          left: 11,
                          right: 11 + 32,
                          top: 9,
                          bottom: 9,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(LucideIcons.arrowUp),
                        padding: EdgeInsets.all(4),
                        constraints: BoxConstraints(),
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Obx(() {
            final text = controller.inputText.value;
            if (text.length / 20 + text.split('\n').length <= 8) {
              return const SizedBox.shrink();
            }
            return Positioned(
              top: -3,
              right: -3,
              child: IconButton(
                tooltip: 'Expand',
                onPressed: () {},
                iconSize: 16,
                icon: const Icon(LucideIcons.maximize2),
                padding: EdgeInsets.all(4),
                constraints: BoxConstraints(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
