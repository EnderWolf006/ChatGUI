import 'dart:ui';

import 'package:chat_gui/app/pages/chat/controller.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ChatDrawer extends GetView<ChatScreenController> {
  const ChatDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FThemeBuildContext(context).theme;
    return Material(
      color: theme.colors.background,
      child: SafeArea(
        right: false,
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FTextField(
                          hint: 'Search...',
                          prefixBuilder: (context, style, states) {
                            return FButton.icon(
                              onPress: () {},
                              style: FButtonStyle.ghost(),
                              child: Icon(
                                FIcons.search,
                                size: 22,
                                color: theme.colors.foreground.withAlpha(200),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 16.0),
                      FButton.icon(
                        onPress: () => {},
                        style: FButtonStyle.ghost(),
                        child: Icon(FIcons.squarePen, size: 22),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                ListTile(
                  title: Text(
                    'New chat',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: theme.colors.foreground,
                    ),
                  ),
                  leading: Icon(
                    FIcons.plus,
                    color: theme.colors.foreground.withAlpha(200),
                  ),
                  onTap: () {
                    print(11);
                  },
                  minTileHeight: 48,
                ),
                ListTile(
                  title: Text(
                    'Assistant',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: theme.colors.foreground,
                    ),
                  ),

                  leading: Icon(
                    FIcons.bot,
                    color: theme.colors.foreground.withAlpha(200),
                  ),
                  onTap: () {},
                  minTileHeight: 48,
                ),
                SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    children: [
                      for (var i = 0; i < 145; i++)
                        ListTile(
                          title: Text(
                            'History Title $i',
                            style: TextStyle(color: theme.colors.foreground),
                          ),
                          onTap: () {},
                          minTileHeight: 48,
                        ),
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
                      color: theme.colors.background.withAlpha(128),
                    ),
                    child: ListTile(
                      title: Text(
                        "Guest User",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: theme.colors.foreground,
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
    );
  }
}
