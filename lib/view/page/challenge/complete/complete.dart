/* 챌린지 완료 페이지 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/page/challenge/complete/widget.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// class
class ChallengeCompletePage extends StatelessWidget {
  const ChallengeCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Challenge challenge = Get.arguments;

    return Scaffold(
      appBar: const ChallengeCompleteAppBar(),
      backgroundColor: challenge.theme['background'],
      body: const ChallengeListView(),
    );
  }
}
