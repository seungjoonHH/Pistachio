/* 커스텀 텍스트 위젯 */

import 'package:pistachio/global/theme.dart';
import 'package:flutter/material.dart';

/// class
class FWText extends StatelessWidget {
  FWText(this.data, {
    Key? key,
    this.style,
    this.color,
    this.maxLines = 1,
  }) : super(key: key);

  final String data;
  TextStyle? style;
  Color? color;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    style ??= textTheme.bodyMedium;
    color ??= FWTheme.black;
    return Text(data,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: style?.apply(color: color),
    );
  }
}
