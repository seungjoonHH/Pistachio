/* 챌린지 디테일 위젯 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/page/challenge/complete.dart';
import 'package:pistachio/presenter/page/challenge/difficulty.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:pistachio/view/widget/widget/card.dart';

// 챌린지 디테일 리스트 뷰
class ChallengeListView extends StatelessWidget {
  const ChallengeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<ChallengePresenter>(
        builder: (controller) {
          return Column(
            children: controller.challenges.map((ch) => ChallengeDetailBody(
              challenge: ch
            )).toList(),
          );
        }
      ),
    );
  }
}

class ChallengeDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChallengeDetailAppBar({Key? key}) : super(key: key);

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
            backgroundColor: PTheme.offWhite,
          );
        }
    );
  }
}

class ChallengeDetailBody extends StatelessWidget {
  const ChallengeDetailBody({Key? key, required this.challenge}) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*Center(
          child: SvgPicture.asset(
            challenge.imageUrls['default'],
            width: 500.0,
            fit: BoxFit.fitHeight,
          ),
        ),*/
        Center(
          child: PCard(
            color: PTheme.offWhite,
            padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 0.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: PText('향고래 바다로\n돌려보내기',
                        style: textTheme.headlineLarge,
                        color: PTheme.black,
                        maxLines: 2,
                        border: true,
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: PText(
                        challenge.descriptions['detail']!.replaceAll('#', ''),
                        style: textTheme.titleSmall,
                        color: PTheme.black,
                        maxLines: 8,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Center(
          child: PButton(
            onPressed: () => ChallengeDifficulty.toChallengeDifficulty(challenge),
            text: '챌린지 하러가기',
            //backgroundColor: challenge.theme['button'],
          ),
        )
      ],
    );
  }
}
