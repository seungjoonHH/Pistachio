/* 챌린지 난이도 페이지 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/page/challenge/create/widget.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';

/// class
class ChallengeCreatePage extends StatelessWidget {
  const ChallengeCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Challenge challenge = Get.arguments;

    return Scaffold(
      appBar: const PAppBar(color: Colors.transparent),
      backgroundColor: PTheme.background,
      body: ChallengeCreateView(challenge: challenge),
    );
  }
}
