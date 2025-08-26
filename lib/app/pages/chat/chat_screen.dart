import 'package:chat_gui/app/components/interactive_drawer.dart';
import 'package:chat_gui/app/pages/chat/components/content.dart';
import 'package:chat_gui/app/pages/chat/components/drawer.dart';
import 'package:chat_gui/app/pages/chat/components/input.dart';
import 'package:chat_gui/app/pages/chat/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatScreenController> {
  const ChatScreen({super.key});

  @override
  Widget build(context) {
    final theme = FThemeBuildContext(context).theme;
    final dividerColor = Color.lerp(theme.colors.border, theme.colors.background, 0.4);
    return InteractiveDrawer(
      controller: controller.drawerController,
      drawer: ChatDrawer(),
      child: FScaffold(
        childPad: false,
        header: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: FHeader.nested(
            title: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: const Text('Gemini-2.5-pro', style: TextStyle(fontSize: 19)),
            ),
            titleAlignment: AlignmentGeometry.centerLeft,
            prefixes: [
              FHeaderAction(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(FIcons.alignLeft, size: 22),
                ),
                onPress: () {
                  controller.drawerController.toggle();
                },
              ),
            ],
            suffixes: [
              FHeaderAction(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(FIcons.squarePen, size: 22),
                ),
                onPress: () {},
              ),
              FHeaderAction(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(FIcons.ellipsisVertical, size: 22),
                ),
                onPress: () {},
              ),
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Obx(
                  () => AnimatedContainer(
                    duration: 328.milliseconds,
                    decoration: BoxDecoration(
                      border: Border(
                        top:
                            controller.scrollOffsetPercent.value > 0
                                ? BorderSide(color: dividerColor!, width: 1)
                                : BorderSide(color: dividerColor!.withAlpha(0), width: 1),
                        bottom:
                            controller.scrollOffsetPercent.value < 1
                                ? BorderSide(color: dividerColor, width: 1)
                                : BorderSide(color: dividerColor.withAlpha(0), width: 1),
                      ),
                    ),
                    child: ChatContent(),
                  ),
                ),
              ),
              ChatInput(),
            ],
          ),
        ),
      ),
    );
  }
}
