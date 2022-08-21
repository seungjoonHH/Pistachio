/* 챌린지 난이도 위젯 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/presenter/page/challenge/complete.dart';
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

class ChallengeDifficultyBody extends StatelessWidget {
  const ChallengeDifficultyBody({Key? key, required this.challenge}) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 60.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/image/page/challenge/left_wing.svg',
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: PText(
                        '챌린지 난이도',
                        style: textTheme.titleLarge,
                        color: PTheme.black,
                        maxLines: 1,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/image/page/challenge/right_wing.svg',
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/image/page/challenge/left_wing.svg',
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: SvgPicture.asset(
                          'assets/image/page/challenge/left_wing.svg',
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/image/page/challenge/left_wing.svg',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PText(
                        '쉬움',
                        style: textTheme.titleLarge,
                        color: PTheme.white,
                        border: true,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: PText(
                          '보통',
                          style: textTheme.titleLarge,
                          color: PTheme.white,
                          border: true,
                        ),
                      ),
                      PText(
                        '어려움',
                        style: textTheme.titleLarge,
                        color: PTheme.white,
                        border: true,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(34.0),
          child: PText(
            '권장 참여 인원 : 1-2명',
            style: textTheme.titleSmall,
            color: PTheme.black,
            maxLines: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(34.0),
          child: PText(
            '아기고래를 바다로 옮겨요!',
            style: textTheme.titleSmall,
            color: PTheme.black,
            maxLines: 1,
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(0.0, 260.0, 0.0, 0.0),
            child: Center(
              child: PButton(
                //onPressed: () => ChallengePresenter.toChallengeMain(),
                onPressed: () => ChallengeComplete.toChallengeComplete(challenge),
                text: '완료',
                //backgroundColor: challenge.theme['button'],
              ),
            )
        )
      ],
    );
  }
}
