/* 챌린지 난이도 위젯 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/text.dart';

// 챌린지 난이도 리스트 뷰
class ChallengeListView extends StatelessWidget {
  const ChallengeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<ChallengePresenter>(
        builder: (controller) {
          return Column(
            children: controller.challenges.map((ch) => ChallengeDifficultyBody(
              challenge: ch
            )).toList(),
          );
        }
      ),
    );
  }
}

class ChallengeDifficultyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChallengeDifficultyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    Challenge challenge = Get.arguments;

    return GetBuilder<ChallengePresenter>(
        builder: (controller) {
          return AppBar(
            elevation: 0.0,
            iconTheme: const IconThemeData(color: PTheme.light),
            backgroundColor: challenge.theme['background'],
          );
        }
    );
  }
}

class ChallengeDifficultyBody extends StatelessWidget {
  const ChallengeDifficultyBody({Key? key, required this.challenge}) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: PText(
            '챌린지 난이도',
            style: textTheme.titleLarge,
            color: PTheme.white,
            maxLines: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(34.0),
          child: PText(
            '권장 참여 인원 : 1-2명',
            style: textTheme.titleSmall,
            color: PTheme.white,
            maxLines: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(34.0),
          child: PText(
            '아기고래를 바다로 옮겨요!',
            style: textTheme.titleSmall,
            color: PTheme.white,
            maxLines: 1,
          ),
        ),
        Container(
          height: 130.0,
        ),
        Center(
          child: PButton(
            onPressed: () => ChallengePresenter.toChallengeMain(),
            text: '컬랙션 보러가기',
            //backgroundColor: challenge.theme['button'],
          ),
        )
      ],
    );
  }
}
