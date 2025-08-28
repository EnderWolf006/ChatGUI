import 'package:chat_gui/components/interactive_drawer.dart';
import 'package:chat_gui/pages/chat/components/content.dart';
import 'package:chat_gui/pages/chat/components/drawer.dart';
import 'package:chat_gui/pages/chat/components/input.dart';
import 'package:chat_gui/pages/chat/controller.dart';
import 'package:chat_gui/utils/cxxxr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ChatScreen extends GetView<ChatScreenController> {
  const ChatScreen({super.key});

  @override
  Widget build(context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InteractiveDrawer(
      scrimColor: context.isDarkMode ? C.g1.d : C.black.l,
      controller: controller.drawerController,
      drawer: ChatDrawer(),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        bottomNavigationBar: SizedBox(height: MediaQuery.of(context).padding.bottom),
        appBar: AppBar(
          titleSpacing: -6,
          title: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton.icon(
              onPressed: () {},
              label: const Text(
                'Gemini-2.5-pro-max-ultra',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              icon: Icon(LucideIcons.chevronDown),
              iconAlignment: IconAlignment.end,
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.onSurface,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: const Size(0, 0),
              ),
            ),
          ),
          backgroundColor: colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.alignLeft),
            onPressed: () => controller.drawerController.toggle(),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(LucideIcons.squarePen)),
            IconButton(onPressed: () {}, icon: const Icon(LucideIcons.ellipsisVertical)),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 328),
                  decoration: BoxDecoration(
                    // NOTE: ListView is reversed
                    border: Border(
                      top:
                          controller.scrollOffsetPercent.value < 1
                              ? BorderSide(color: C.g2.r.withAlpha(160), width: 1)
                              : BorderSide(color: C.g2.r.withAlpha(0), width: 1),
                      bottom:
                          controller.scrollOffsetPercent.value > 0
                              ? BorderSide(color: C.g2.r.withAlpha(160), width: 1)
                              : BorderSide(color: C.g2.r.withAlpha(0), width: 1),
                    ),
                  ),
                  child: const ChatContent(),
                ),
              ),
            ),
            const ChatInput(),
          ],
        ),
      ),
    );
  }
}
