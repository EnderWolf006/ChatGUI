import 'package:chat_gui/utils/cxxxr.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:highlight/highlight.dart' as hl;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MarkdownRenderer extends GetView {
  const MarkdownRenderer(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GptMarkdown(
        text,
        highlightBuilder: (context, text, style) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: C.g2.r,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(text, style: style),
          );
        },
        useDollarSignsForLatex: true,
        style: TextStyle(color: C.black.r, fontSize: 16, height: 1.5),
        codeBuilder: (BuildContext context, String name, String code, bool closed) {
          return _CodeBlockView(language: name, code: code);
        },
        linkBuilder: (context, text, url, style) {
          return Text.rich(
            text,
            style: style.copyWith(decoration: TextDecoration.underline),
          );
        },
        imageBuilder: (context, imageUrl) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: ExtendedImage.network(
              imageUrl,
              fit: BoxFit.contain,
              cache: true,
              clipBehavior: Clip.antiAlias,
              height: 240,
              borderRadius: BorderRadius.circular(10),
              loadStateChanged: (state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return Container(
                      width: double.infinity,
                      height: 240,
                      color: C.g1.r,
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: C.black.r,
                          ),
                        ),
                      ),
                    );
                  case LoadState.completed:
                    return null;
                  case LoadState.failed:
                    return Container(
                      width: double.infinity,
                      height: 240,
                      color: C.g1.r,
                      child: Center(
                        child: Icon(LucideIcons.imageOff, size: 40, color: C.black.r),
                      ),
                    );
                }
              },
            ),
          );
        },
        onLinkTap: (url, title) async {
          await launchUrlString(url);
        },
      ),
    );
  }
}

class _CodeBlockView extends StatelessWidget {
  const _CodeBlockView({required this.language, required this.code});
  final String language;
  final String code;

  @override
  Widget build(BuildContext context) {
    final langLabel = (language.isEmpty ? 'code' : language).toLowerCase();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeMap = isDark ? atomOneDarkTheme : atomOneLightTheme;
    final lang = _normalizeLanguage(langLabel);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(color: C.g1.r, borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 42, left: 12, right: 12, bottom: 12),
            child: _RichHighlightCode(
              code: code.trimRight(),
              language: lang,
              theme: themeMap,
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Text(
              langLabel.isEmpty
                  ? ''
                  : langLabel[0].toUpperCase() + langLabel.substring(1),
              style: TextStyle(
                color: C.black.r,
                fontSize: 14,
                height: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: code));
              },
              icon: Icon(LucideIcons.copy),
              constraints: BoxConstraints(),
              iconSize: 14,
              style: IconButton.styleFrom(
                foregroundColor: C.black.r,
                padding: EdgeInsets.all(8),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _normalizeLanguage(String input) {
  final l = input.toLowerCase();
  switch (l) {
    case 'js':
      return 'javascript';
    case 'ts':
    case 'typescript':
      return 'typescript';
    case 'py':
      return 'python';
    case 'c++':
      return 'cpp';
    case 'sh':
      return 'bash';
    case 'md':
    case 'markdown':
      return 'markdown';
    case 'yml':
      return 'yaml';
    default:
      return l.isEmpty ? 'plaintext' : l;
  }
}

class _RichHighlightCode extends StatefulWidget {
  const _RichHighlightCode({
    required this.code,
    required this.language,
    required this.theme,
  });

  final String code;
  final String language;
  final Map<String, TextStyle> theme;

  @override
  State<_RichHighlightCode> createState() => _RichHighlightCodeState();
}

class _RichHighlightCodeState extends State<_RichHighlightCode> {
  // Cache parsed highlight nodes so we don't parse on every rebuild.
  late List<hl.Node> _nodes;

  @override
  void initState() {
    super.initState();
    _parse();
  }

  @override
  void didUpdateWidget(covariant _RichHighlightCode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.code != widget.code || oldWidget.language != widget.language) {
      _parse();
    }
  }

  void _parse() {
    final res = hl.highlight.parse(
      widget.code,
      language:
          (widget.language == 'plaintext' || widget.language.isEmpty)
              ? null
              : widget.language,
      autoDetection: (widget.language == 'plaintext' || widget.language.isEmpty),
    );
    _nodes = res.nodes ?? const [];
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontFamilyFallback: const [
            'MapleMono',
            'Menlo',
            'Consolas',
            'Roboto Mono',
            'Courier New',
            'monospace',
          ],
          fontSize: 15,
          color: C.black.r,
          height: 1.4,
        ),
        children: _toTextSpans(_nodes),
      ),
    );
  }

  List<TextSpan> _toTextSpans(List<hl.Node> nodes) {
    final spans = <TextSpan>[];
    for (final node in nodes) {
      if (node.value != null) {
        final style = node.className != null ? widget.theme[node.className!] : null;
        spans.add(TextSpan(text: node.value, style: style));
      } else if (node.children != null) {
        final style = node.className != null ? widget.theme[node.className!] : null;
        spans.add(TextSpan(style: style, children: _toTextSpans(node.children!)));
      }
    }
    return spans;
  }
}
