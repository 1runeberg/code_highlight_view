import 'package:flutter/material.dart';
import 'package:highlight/highlight.dart' show highlight, Node;


/// Highlight Flutter Widget
class CodeHighlightView extends StatelessWidget {
  /// The original code to be highlighted
  final String source;

  /// Highlight language
  ///
  /// It is recommended to give it a value for performance
  ///
  /// [All available languages](https://github.com/pd4d10/highlight/tree/master/highlight/lib/languages)
  final String? language;

  /// If text is selectable
  final bool isSelectable;

  /// Highlight theme
  ///
  /// [All available themes](https://github.com/pd4d10/highlight/blob/master/flutter_highlight/lib/themes)
  final Map<String, TextStyle> theme;

  /// Padding
  final EdgeInsetsGeometry? padding;

  /// Precomputed Text styles
  final TextStyle textStyle;

  const CodeHighlightView(
    this.source, {
    this.language,
    this.isSelectable = true,
    this.theme = const {},
    this.padding,
    required this.textStyle,
  });

  List<TextSpan> _convert(List<Node> nodes) {
    List<TextSpan> spans = [];
    var currentSpans = spans;
    List<List<TextSpan>> stack = [];

    _traverse(Node node) {
      if (node.value != null) {
        currentSpans.add(node.className == null
            ? TextSpan(text: node.value)
            : TextSpan(text: node.value, style: theme[node.className!]));
      } else if (node.children != null) {
        List<TextSpan> tmp = [];
        currentSpans.add(TextSpan(children: tmp, style: theme[node.className!]));
        stack.add(currentSpans);
        currentSpans = tmp;

        node.children!.forEach((n) {
          _traverse(n);
          if (n == node.children!.last) {
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
          }
        });
      }
    }

    for (var node in nodes) {
      _traverse(node);
    }

    return spans;
  }

  TextSpan _getTextHighlight() {
    return TextSpan(
      style: textStyle,
      children: _convert(highlight.parse(source, language: language).nodes!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme['root']?.backgroundColor ?? const Color(0xffffffff),
      padding: padding,
      child: isSelectable
          ? SelectableText.rich(_getTextHighlight())
          : RichText(text: _getTextHighlight()),
    );
  }
}
