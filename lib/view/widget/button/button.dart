/* 커스텀 버튼 위젯 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:flutter/material.dart';

/// class
class PButton extends StatelessWidget {
  PButton({
    Key? key,
    this.text,
    this.child,
    required this.onPressed,
    this.fill = true,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 30.0, vertical: 10.0,
    ),
    this.constraints,
    Color? color,
  }) : assert(
  text == null || child == null,
  ), color = color ?? PTheme.secondary[40], super(key: key);

  final String? text;
  final Widget? child;
  final VoidCallback onPressed;
  final bool fill;
  final EdgeInsets padding;
  final BoxConstraints? constraints;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: fill ? color : PTheme.white,
              borderRadius: BorderRadius.circular(20.0),
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  padding: padding,
                  constraints: constraints,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: color!),
                  ),
                  child: Center(
                    child: child ?? PText(text!,
                      color: fill
                          ? PTheme.white
                          : PTheme.secondary[40],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PDirectButton extends StatelessWidget {
  const PDirectButton({
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
            bottom: BorderSide(color: PTheme.black),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PText(text,
              color: PTheme.black,
              style: const TextStyle(fontSize: 13.0),
            ),
            const Icon(Icons.arrow_forward_ios, size: 15.0),
          ],
        ),
      ),
    );
  }
}

class PIconButton extends StatelessWidget {
  const PIconButton(this.iconData, {
    Key? key,
    required this.onPressed,
    this.size = 66.0,
    Color? backgroundColor,
    Color? iconColor,
  }) : backgroundColor = backgroundColor ?? const Color(0xFFD6BDAC),
        iconColor = iconColor ?? PTheme.black,
        super(key: key);

  final IconData iconData;
  final VoidCallback onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(size * .5),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(size * .5),
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(iconData,
            size: size * .7,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
