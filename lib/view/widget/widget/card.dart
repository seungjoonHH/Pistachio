import 'package:flutter/material.dart';
import 'package:pistachio/global/theme.dart';

class PCard extends StatelessWidget {
  const PCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(20.0),
    this.onPressed,
    this.color = PTheme.light,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: Border.all(
              color: PTheme.black,
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
