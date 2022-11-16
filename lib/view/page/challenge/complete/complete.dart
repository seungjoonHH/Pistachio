/* 챌린지 완료 페이지 */

import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/view/page/challenge/complete/widget.dart';
import 'package:pistachio/global/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';

/// class
class ChallengePartyCompletePage extends StatelessWidget {
  const ChallengePartyCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Party party = Get.arguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PAppBar(color: Colors.transparent),
      backgroundColor: PTheme.background,
      body: ChallengePartyCompleteView(party: party),
    );
  }
}
