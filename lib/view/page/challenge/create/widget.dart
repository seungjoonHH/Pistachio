/* 챌린지 난이도 위젯 */

import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/json/challenge.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/page/challenge/create.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/text.dart';

// 챌린지 난이도 리스트 뷰
class ChallengeCreateView extends StatelessWidget {
  const ChallengeCreateView({
    Key? key,
    required this.challenge,
  }) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChallengeCreate>(
      builder: (controller) {
        String word = challenge.levels[controller.difficulty.name]['word'];
        String description = challenge.descriptions['detail'].replaceAll('##', '#$word#');
        List<String> descriptions = description.split('#');
        List<Color> colors = List.generate(
          descriptions.length, (index) => index % 2 == 0
            ? PTheme.black : PTheme.colorB,
        );

        int maxMember = challenge.levels[controller.difficulty.name]['maxMember'];
        String memberString = '${maxMember > 1 ? '1~' : ''}$maxMember';

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
                        PText('챌린지 난이도',
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
                      children: Difficulty.values.map((diff) => GestureDetector(
                        onTap: () => controller.changeDifficulty(diff),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                children: [
                                  BadgeWidget(
                                    badge: challenge.badges[diff],
                                    onPressed: () => controller.changeDifficulty(diff),
                                  ),
                                  Container(
                                    width: 80.0.r,
                                    height: 80.0.r,
                                    decoration: ShapeDecoration(
                                      color: diff == controller.difficulty
                                          ? Colors.transparent
                                          : PTheme.black.withOpacity(.2),
                                      shape: PolygonBorder(
                                        sides: 6,
                                        side: BorderSide(
                                          width: 4.0,
                                          color: diff == controller.difficulty
                                              ? PTheme.colorB
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            PText(diff.kr,
                              style: textTheme.titleLarge,
                              color: diff == controller.difficulty
                                  ? PTheme.colorB
                                  : PTheme.black,
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PText('권장 참여 인원 : $memberString명',
                      style: textTheme.headlineSmall,
                    ),
                    SizedBox(height: 30.0.h),
                    SizedBox(
                      height: 350.0.h,
                      child: RichText(
                        text: TextSpan(
                          children: List.generate(descriptions.length, (index) => TextSpan(
                            text: descriptions[index],
                            style: textTheme.labelLarge?.apply(color: colors[index]),
                          )).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 50.0,
              child: PButton(
                onPressed: () => controller.challengeCreateButtonPressed(challenge),
                text: '챌린지 생성하기',
                stretch: true,
                constraints: const BoxConstraints(maxWidth: 340.0),
              ),
            ),
          ],
        );
      }
    );
  }
}
