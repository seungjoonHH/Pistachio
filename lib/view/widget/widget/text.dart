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
  }) : style = style ?? textTheme.bodyMedium, super(key: key);

  final String data;
  final TextStyle? style;
  final Color? color;
  final int maxLines;
  final bool bold;
  final bool italic;

  @override
  Widget build(BuildContext context) {
    return Text(data,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: style?.merge(TextStyle(
        color: color,
        fontWeight: bold
            ? FontWeight.bold
            : FontWeight.normal,
        fontStyle: italic
            ? FontStyle.italic
            : FontStyle.normal,
      )),
    );
  }
}
