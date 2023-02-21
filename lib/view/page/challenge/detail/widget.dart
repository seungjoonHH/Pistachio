/* 챌린지 디테일 위젯 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/json/challenge.dart';
import 'package:pistachio/presenter/page/challenge/create.dart';
import 'package:pistachio/presenter/page/challenge/main.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:pistachio/view/widget/widget/card.dart';

// 챌린지 디테일 리스트 뷰
class ChallengeDetailView extends StatelessWidget {
  const ChallengeDetailView({
    Key? key,
    required this.challenge,
  }) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    final challengeMain = Get.find<ChallengeMain>();

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Image.asset(
              challenge.imageUrls['default'],
              fit: BoxFit.fitWidth,
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
        Positioned.fill(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 230.0.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 36.0.w),
                  child: PCard(
                    color: PTheme.background,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PText(challenge.title!,
                          align: TextAlign.center,
                          style: textTheme.headlineLarge,
                          color: PTheme.black,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 20.0),
                        PText('14일',
                          align: TextAlign.center,
                          style: textTheme.labelLarge,
                          color: PTheme.black,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 30.0),
                        PText(
                          challenge.descriptions['detail']!.replaceAll('##', challenge.word),
                          align: TextAlign.center,
                          style: textTheme.labelLarge,
                          color: PTheme.black,
                          maxLines: 10,
                        ),
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(horizontal: 36.0.w),
              child: Row(
                children: [
                  PButton(
                    onPressed: challengeMain.challengeJoinButtonPressed,
                    text: '챌린지 참여하기',
                    stretch: true,
                    textColor: PTheme.black,
                    multiple: true,
                  ),
                  SizedBox(width: 20.0.w),
                  PButton(
                    onPressed: () => ChallengeCreate.toChallengeCreate(challenge),
                    text: '챌린지 생성하기',
                    stretch: true,
                    multiple: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 70.0.h),
          ],
        ),
      ],
    );
  }
}