import 'dart:ui';

import 'package:chat_gui/pages/chat/controller.dart';
import 'package:chat_gui/store/app_store.dart';
import 'package:chat_gui/utils/cxxxr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ChatDrawer extends GetView<ChatScreenController> {
  const ChatDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isTablet = Get.find<AppStore>().tabletMode.value;
    final isDark = colorScheme.brightness == Brightness.dark;
    return Material(
      color: colorScheme.surface,
      child: Container(
        decoration:
            isTablet && isDark
                ? BoxDecoration(
                  border: Border(right: BorderSide(color: C.g1.r, width: 1)),
                )
                : null,
        child: SafeArea(
          right: false,
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: C.white.r,
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              TextField(
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.onSurface,
                                  height: 1.5,
                                ),
                                controller: controller.searchInputController,
                                decoration: InputDecoration(
                                  hintText: 'chat.drawer.search.placeholder'.tr,
                                  contentPadding: EdgeInsets.only(
                                    left: 11 + 32,
                                    right: 11,
                                    top: 9,
                                    bottom: 9,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 5,
                                top: 5,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(LucideIcons.search),
                                  padding: EdgeInsets.all(4),
                                  constraints: BoxConstraints(),
                                  style: IconButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    foregroundColor:
                                        Theme.of(context).colorScheme.onSecondary,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.all(9),
                          icon: const Icon(LucideIcons.squarePen),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      children: [
                        ListTile(
                          title: Text(
                            'chat.drawer.actionButton.newChat'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          leading: Icon(
                            LucideIcons.squarePen,
                            color: colorScheme.onSurface.withAlpha(200),
                          ),
                          onTap: () {
                          },
                          minTileHeight: 48,
                        ),
                        ListTile(
                          title: Text(
                            'chat.drawer.actionButton.assistant'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          leading: Icon(
                            LucideIcons.bot,
                            color: colorScheme.onSurface.withAlpha(200),
                          ),
                          onTap: () {},
                          minTileHeight: 48,
                        ),
                        const SizedBox(height: 8),
                        for (var i = 0; i < 145; i++)
                          ListTile(
                            title: Text(
                              'History Title $i',
                              style: TextStyle(color: colorScheme.onSurface),
                            ),
                            onTap: () {},
                            minTileHeight: 48,
                          ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewPadding.bottom,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withAlpha(128),
                      ),
                      child: ListTile(
                        title: Text(
                          "Guest User",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        leading: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.purple,
                          ),
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
