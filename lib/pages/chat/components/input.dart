import 'package:chat_gui/pages/chat/controller.dart';
import 'package:chat_gui/utils/cxxxr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ChatInput extends GetView<ChatScreenController> {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                            height: 1.5,
                          ),
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
                if (text.length / 36 + text.split('\n').length <= 8) {
                  return const SizedBox.shrink();
                }
                return Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    tooltip: 'Expand',
                    onPressed: () {
                      _openLargeInput(constraints);
                    },
                    iconSize: 16,
                    icon: const Icon(LucideIcons.maximize2),
                    padding: EdgeInsets.all(8),
                    constraints: BoxConstraints(),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

void _openLargeInput(BoxConstraints constraints) {
  showModalBottomSheet(
    constraints: BoxConstraints(maxWidth: constraints.maxWidth),
    context: Get.context!,
    backgroundColor: C.white.r,
    barrierColor: C.g3.r.withAlpha(88),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),

    builder: (ctx) {
      return Container(
        height: MediaQuery.of(Get.context!).size.height,
        margin: EdgeInsets.only(
          left: 8,
          right: 8,
          top: MediaQuery.of(Get.context!).padding.top + 8,
          bottom: MediaQuery.of(Get.context!).padding.bottom + 8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                controller: Get.find<ChatScreenController>().inputController,
                autofocus: true,
                minLines: 66,
                maxLines: null,
                style: TextStyle(fontSize: 16, color: C.black.r, height: 1.5),
                decoration: InputDecoration(
                  hintText: 'chat.input.placeholder'.tr,
                  contentPadding: EdgeInsets.all(0),
                  fillColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(width: 8),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  icon: Icon(LucideIcons.minimize2),
                ),
                Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () {},
                  icon: Icon(LucideIcons.arrowUp),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(Get.context!).colorScheme.primary,
                    foregroundColor: Theme.of(Get.context!).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
