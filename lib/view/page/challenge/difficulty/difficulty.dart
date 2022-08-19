/* 챌린지 난이도 페이지 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/page/challenge/difficulty/widget.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// class
class ChallengeDifficultyPage extends StatelessWidget {
  const ChallengeDifficultyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Challenge challenge = Get.arguments;

    return Scaffold(
      appBar: const ChallengeDifficultyAppBar(),
      backgroundColor: challenge.theme['background'],
      body: const ChallengeListView(),
    );
  }
}
