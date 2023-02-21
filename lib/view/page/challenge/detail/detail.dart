/* 챌린지 디테일 페이지 */

import 'package:pistachio/model/class/json/challenge.dart';
import 'package:pistachio/view/page/challenge/detail/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';

/// class
class ChallengeDetailPage extends StatelessWidget {
  const ChallengeDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Challenge challenge = Get.arguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PAppBar(color: Colors.transparent),
      body: ChallengeDetailView(challenge: challenge),
    );
  }
}
