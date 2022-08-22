/* 챌린지 난이도 위젯 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/presenter/page/challenge/complete.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/collection.dart';
import 'package:pistachio/view/widget/widget/text.dart';

// 챌린지 난이도 리스트 뷰
class ChallengeDifficultyView extends StatelessWidget {
  const ChallengeDifficultyView({
    Key? key,
    required this.challenge,
  }) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      'assets/image/page/challenge/left_wing.svg',
                    ),
                    PText(
                      '챌린지 난이도',
                      style: textTheme.titleLarge,
                      color: PTheme.black,
                    ),
                    SvgPicture.asset(
                      'assets/image/page/challenge/right_wing.svg',
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const CollectionWidget(),
                        const SizedBox(height: 20.0),
                        PText('쉬움',
                          style: textTheme.titleLarge,
                          color: PTheme.white,
                          border: true,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const CollectionWidget(),
                        const SizedBox(height: 20.0),
                        PText('중간',
                          style: textTheme.titleLarge,
                          color: PTheme.white,
                          border: true,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const CollectionWidget(),
                        const SizedBox(height: 20.0),
                        PText('어려움',
                          style: textTheme.titleLarge,
                          color: PTheme.white,
                          border: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText('권장 참여 인원 : 1-2명',
                  style: textTheme.titleSmall,
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 400.0,
                  child: PText(challenge.descriptions['detail']
                      .replaceAll('##', challenge.levels['easy']['word']),
                    style: textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 50.0,
          child: PButton(
            onPressed: () => ChallengeComplete.toChallengeComplete(challenge),
            text: '완료',
            stretch: true,
            constraints: const BoxConstraints(maxWidth: 340.0),
          ),
        ),
      ],
    );
  }
}
