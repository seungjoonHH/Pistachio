import 'package:flutter/material.dart';
import 'package:pistachio/global/theme.dart';

class PCard extends StatelessWidget {
  const PCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(20.0),
    this.onPressed,
    this.color = PTheme.white,
    this.rounded = false,
    this.border = true,
    this.borderColor = PTheme.black,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onPressed;
  final Color color;
  final bool rounded;
  final bool border;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    BorderRadius? radius = rounded
        ? BorderRadius.circular(20.0) : null;

    return Material(
      color: color,
      borderRadius: radius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: radius,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: Border.all(
              color: border ? borderColor : Colors.transparent,
              width: 1.5,
            ),
            borderRadius: radius,
          ),
          child: child,
        ),
      ),
    );
  }
}
