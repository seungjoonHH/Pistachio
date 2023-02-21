import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/class/json/challenge.dart';
import 'package:pistachio/model/enum/dialog.dart';
import 'package:pistachio/model/enum/difficulty.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/challenge/main.dart';
import 'package:pistachio/presenter/page/challenge/party/main.dart';
import 'package:pistachio/view/widget/function/dialog.dart';
import 'package:pistachio/view/widget/widget/text.dart';

/// class
class ChallengeCreate extends GetxController {
  /// static methods
  // 챌린지 생성 페이지로 이동
  static void toChallengeCreate(Challenge challenge) {
    final challengeCreate = Get.find<ChallengeCreate>();
    challengeCreate.init();
    Get.toNamed('/challenge/create', arguments: challenge);
  }

  /// attributes
  Difficulty difficulty = Difficulty.easy;

  /// methods
  // 초기화
  void init() {
    difficulty = Difficulty.easy;
    update();
  }

  // 난이도 변경
  void changeDifficulty(Difficulty diff) {
    difficulty = diff; update();
  }

  // 챌린지 생성 버튼 클릭 시
  void challengeCreateButtonPressed(Challenge challenge) async {
    final userP = Get.find<UserPresenter>();
    String code = await userP.createMyParty(challenge, difficulty);
    showChallengeCreatedDialog(code);
  }

  // 챌린지 생성 팝업
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