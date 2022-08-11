/* 커스텀 버튼 위젯 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:flutter/material.dart';

/// class
class FWButton extends StatelessWidget {
  const FWButton({
    Key? key,
    this.text,
    this.child,
    required this.onPressed,
    this.fill = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 30.0, vertical: 10.0,
    ),
    this.constraints,
  }) : assert(
  text == null || child == null,
  ), super(key: key);

  final String? text;
  final Widget? child;
  final VoidCallback onPressed;
  final bool fill;
  final EdgeInsets padding;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff54bab9),
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: padding,
          constraints: constraints,
          child: Center(
            child: child ?? FWText(text!,
              color: FWTheme.white,
            ),
          ),
        ),
      ),
    );
  }
}

class FWDirectButton extends StatelessWidget {
  const FWDirectButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: FWTheme.black),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FWText(text,
              color: FWTheme.black,
              style: const TextStyle(fontSize: 13.0),
            ),
            const Icon(Icons.arrow_forward_ios, size: 15.0),
          ],
        ),
      ),
    );
  }
}

