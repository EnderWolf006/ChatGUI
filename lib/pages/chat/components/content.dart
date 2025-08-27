import 'package:chat_gui/pages/chat/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatContent extends GetView<ChatScreenController> {
  const ChatContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: ListView(
        reverse: true,
        padding: EdgeInsets.zero,
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        children:
            [
              for (var i = 0; i < 145; i++)
                Text(
                  'Message Message $i',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
            ].reversed.toList(),
      ),
    );
  }
}
