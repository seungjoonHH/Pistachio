import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PLogo extends StatelessWidget {
  const PLogo({Key? key}) : super(key: key);

  static const String asset = 'assets/image/logo/pistachio.svg';

  @override
  Widget build(BuildContext context) => Center(child: SvgPicture.asset(asset));
}