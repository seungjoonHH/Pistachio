import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/page/challenge/party/main.dart';
import 'package:pistachio/view/page/challenge/party/widget.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';

class ChallengePartyMainPage extends StatelessWidget {
  const ChallengePartyMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: GlobalPresenter.closeBottomBar,
      child: Scaffold(
        backgroundColor: PTheme.background,
        appBar: const PAppBar(title: '내 챌린지'),
        body: GetBuilder<ChallengePartyMain>(
          builder: (controller) {
            return PartyMainView(party: controller.loadedParty!);
          }
        ),
      ),
    );

  }
}
