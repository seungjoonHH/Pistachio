/* 커스텀 텍스트 위젯 */

import 'package:pistachio/global/theme.dart';
import 'package:flutter/material.dart';

/// class
class PText extends StatelessWidget {
  PText(this.data, {
    Key? key,
    TextStyle? style,
    this.color = PTheme.black,
    this.maxLines = 1,
    this.bold = false,
    this.italic = false,
    this.border = false,
    this.borderWidth = .8,
    this.align = TextAlign.left,
  }) : style = style ?? textTheme.bodyMedium, super(key: key);

  final String data;
  final TextStyle? style;
  final Color? color;
  final int maxLines;
  final bool bold;
  final bool italic;
  final bool border;
  final double borderWidth;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    TextStyle mergeStyle = TextStyle(
      fontWeight: bold
          ? FontWeight.bold
          : FontWeight.normal,
      fontStyle: italic
          ? FontStyle.italic
          : FontStyle.normal,
    );

    return Stack(
      children: [
        Text(data,
          textAlign: align,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: style?.merge(mergeStyle).apply(
            color: color,
          ),
        ),
        if (border)
        Text(data,
          textAlign: align,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: style?.merge(mergeStyle).merge(TextStyle(
            foreground: border ? (Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = borderWidth
              ..color = PTheme.black
            ) : null,
          )),
        ),
      ],
    );
  }
}

class PTexts extends StatelessWidget {
  PTexts(this.texts, {
    Key? key,
    required this.colors,
    TextStyle? style,
    this.bold = false,
    this.italic = false,
    this.border = false,
    this.borderWidth = 1.0,
    this.alignment = MainAxisAlignment.center,
  }) : assert(texts.length == colors.length),
        style = style ?? textTheme.bodyMedium,
        super(key: key);

  final List<String> texts;
  final List<Color> colors;
  final TextStyle? style;
  final bool bold;
  final bool italic;
  final bool border;
  final double borderWidth;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(texts.length, (i) => Row(
        children: [
          if (i > 0)
          PText(' ',
            style: style,
            bold: bold,
            italic: italic,
            border: border,
            borderWidth: borderWidth,
          ),
          PText(texts[i],
            color: colors[i],
            style: style,
            bold: bold,
            italic: italic,
            border: border,
            borderWidth: borderWidth,
          ),
        ],
      )),
    );
  }
}
