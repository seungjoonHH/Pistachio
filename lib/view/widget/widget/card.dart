import 'package:flutter/material.dart';
import 'package:pistachio/global/theme.dart';

class PCard extends StatelessWidget {
  const PCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(20.0),
    this.onPressed,
    this.color = PTheme.light,
    this.stretch = false,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onPressed;
  final Color color;
  final bool stretch;

  @override
  Widget build(BuildContext context) {
    Widget content = Material(
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            stretch ? Expanded(child: content) : content,
          ],
        ),
      ],
    );
  }
}
