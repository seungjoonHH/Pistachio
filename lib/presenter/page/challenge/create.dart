import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/class/json/challenge.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/challenge/main.dart';
import 'package:pistachio/presenter/page/challenge/party/main.dart';
import 'package:pistachio/view/widget/function/dialog.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class ChallengeCreate extends GetxController {
  static void toChallengeCreate(Challenge challenge) {
    final challengeCreate = Get.find<ChallengeCreate>();
    challengeCreate.init();
    Get.toNamed('/challenge/create', arguments: challenge);
  }

  Difficulty difficulty = Difficulty.easy;

  void init() {
    difficulty = Difficulty.easy;
    update();
  }

  void changeDifficulty(Difficulty diff) {
    difficulty = diff; update();
  }

  void challengeCreateButtonPressed(Challenge challenge) async {
    final userPresenter = Get.find<UserPresenter>();
    String code = await userPresenter.createMyParties(challenge, difficulty);
    showChallengeCreatedDialog(code);
  }

  void showChallengeCreatedDialog(String code) {
    showPDialog(
      title: '챌린지 생성',
      content: Column(
        children: [
          Center(
            child: PText(code,
              style: textTheme.titleLarge,
              color: PTheme.colorB,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: PText('챌린지가 생성되었습니다.'),
          ),
        ],
      ),
      type: DialogType.mono,
      onPressed: () {
        Get.back();
        PUser user = Get.find<UserPresenter>().loggedUser;
        ChallengeMain.toChallengeMain();
        ChallengePartyMain.toChallengePartyMain(user.parties[code]!);
      },
    );
  }
}