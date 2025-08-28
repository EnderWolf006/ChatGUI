import 'package:chat_gui/utils/cxxxr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class MarkdownRenderer extends GetView {
  const MarkdownRenderer(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return GptMarkdown(
      text,
      useDollarSignsForLatex: true,
      style: TextStyle(color: C.black.r, fontSize: 16, height: 1.5),
      followLinkColor: true, 
    );
  }
}
