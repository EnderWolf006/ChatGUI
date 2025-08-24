import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  final count = Rx(0);
}

class ChatScreen extends GetView<ChatScreenController> {
  @override
  Widget build(_) => FScaffold(
    header: FHeader.nested(
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: const Text('Gemini-2.5-pro'),
      ),
      titleAlignment: AlignmentGeometry.centerLeft,
      prefixes: [
        FHeaderAction(
          icon: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(FIcons.alignLeft),
          ),
          onPress: () {},
        ),
      ],
      suffixes: [
        FHeaderAction(
          icon: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(FIcons.squarePen),
          ),
          onPress: () {},
        ),
        FHeaderAction(
          icon: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(FIcons.ellipsisVertical),
          ),
          onPress: () {},
        ),
      ],
    ),
    child: Column(),
  );
}
