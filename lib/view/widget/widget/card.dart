import 'package:flutter/material.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/enum.dart';

class PCard extends StatelessWidget {
  const PCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(20.0),
    this.onPressed,
    this.color = PTheme.white,
    this.rounded = false,
    this.borderType = BorderType.all,
    this.borderColor = PTheme.black,
    this.borderWidth = 1.5,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onPressed;
  final Color color;
  final bool rounded;
  final BorderType borderType;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    BorderRadius? radius = rounded
        ? BorderRadius.circular(20.0) : null;

    bool leftBorder = [BorderType.left, BorderType.vertical, BorderType.all].contains(borderType);
    bool topBorder = [BorderType.top, BorderType.horizontal, BorderType.all].contains(borderType);
    bool rightBorder = [BorderType.right, BorderType.vertical, BorderType.all].contains(borderType);
    bool bottomBorder = [BorderType.bottom, BorderType.horizontal, BorderType.all].contains(borderType);

    return Material(
      color: color,
      borderRadius: radius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: radius,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: Border(
              left: leftBorder ? BorderSide(
                color: borderColor,
                width: borderWidth,
              ) : BorderSide.none,
              top: topBorder ? BorderSide(
                color: borderColor,
                width: borderWidth,
              ) : BorderSide.none,
              right: rightBorder ? BorderSide(
                color: borderColor,
                width: borderWidth,
              ) : BorderSide.none,
              bottom: bottomBorder ? BorderSide(
                color: borderColor,
                width: borderWidth,
              ) : BorderSide.none,

            ),
            borderRadius: radius,
          ),
          child: child,
        ),
      ),
    );
  }
}
