import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RAnimation extends StatelessWidget {
  const RAnimation(
      {Key? key,
      required this.rName,
      required this.abName,
      required this.aName})
      : super(key: key);

  final String rName;
  final String abName;
  final String aName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: RiveAnimation.asset(rName, artboard: abName, animations: [aName]),
    );
  }
}
