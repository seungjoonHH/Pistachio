import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RAnimation extends StatelessWidget {
  const RAnimation({Key? key,
    required this.rname,
    required this.abname,
    required this.aname}) : super(key: key);

  final String rname;
  final String abname;
  final String aname;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: RiveAnimation.asset(
        rname,
        artboard: abname,
        animations: [aname]),
    );
  }
}
