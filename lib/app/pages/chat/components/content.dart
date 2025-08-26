import 'package:chat_gui/app/pages/chat/controller.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';

class ChatContent extends GetView<ChatScreenController> {
  const ChatContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FThemeBuildContext(context).theme;

    return Container(
      height: double.infinity,
      decoration: BoxDecoration(color: theme.colors.background),
      child: ListView(
        controller: controller.scrollController,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(8),
        children: [
          for (var i = 0; i < 145; i++)
            Text(
              'Message Message $i',
              style: TextStyle(fontSize: 16, color: theme.colors.foreground),
            ),
        ],
      ),
    );
  }
}
