/* 커스텀 버튼 위젯 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:flutter/material.dart';

/// class
class PButton extends StatelessWidget {
  const PButton({
    Key? key,
    this.text,
    this.child,
    required this.onPressed,
    this.fill = true,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 30.0, vertical: 10.0,
    ),
    this.constraints,
    Color? backgroundColor,
    Color? textColor,
    this.stretch = false,
    this.multiple = false,
  }) : assert(
  text == null || child == null,
  ), backgroundColor = backgroundColor ?? PTheme.black,
    textColor = textColor ?? (fill ? PTheme.white : PTheme.black),
    super(key: key);

  final String? text;
  final Widget? child;
  final VoidCallback onPressed;
  final bool fill;
  final EdgeInsets padding;
  final BoxConstraints? constraints;
  final Color? backgroundColor;
  final Color? textColor;
  final bool stretch;
  final bool multiple;

  @override
  Widget build(BuildContext context) {
    Widget content = Material(
      color: fill ? backgroundColor : Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: padding,
          constraints: multiple ? null : constraints ?? BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: PTheme.black, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (stretch) const Expanded(child: SizedBox()),
              child ?? PText(text!, color: textColor),
              if (stretch) const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
    return multiple ? Expanded(child: content) : content;
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

class PTextButton extends StatelessWidget {
  const PTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    Color? color,
  }) : color = color ?? PTheme.black, super(key: key);

  final VoidCallback onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(5.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0, vertical: 2.0,
          ),
          child: PText(text, color: color),
        ),
      ),
    );
  }
}
