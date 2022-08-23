import 'package:flutter/material.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/page/onboarding/widget.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: PTheme.offWhite,
      body: CarouselView(),
    );
  }
}
