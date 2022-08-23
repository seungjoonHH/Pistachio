/* 챌린지 완료 위젯 */

import 'package:flutter/material.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/presenter/page/challenge/difficulty.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/collection.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:pistachio/view/widget/widget/card.dart';

// 챌린지 완료 리스트 뷰
class ChallengeCompleteView extends StatelessWidget {
  const ChallengeCompleteView({
    Key? key,
    required this.challenge,
  }) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            Image.asset(
              challenge.imageUrls['complete'],
              height: 250.0,
              fit: BoxFit.fitHeight,
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
        Positioned(
          top: 200.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PCard(
                color: PTheme.offWhite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PText('${challenge.title!} 성공!',
                      align: TextAlign.center,
                      style: textTheme.headlineLarge,
                      color: PTheme.black,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 30.0),
                    PText(
                      challenge.descriptions['complete']!.replaceAll('#', ''),
                      align: TextAlign.center,
                      style: textTheme.labelLarge,
                      color: PTheme.black,
                      maxLines: 10,
                    ),
                    const SizedBox(
                      height: 80.0,
                      child: CollectionWidget(
                        // collection: CollectionPresenter.getCollection(
                        //   challenge.levels[diff],
                        // )!,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 50.0,
          child: PButton(
            onPressed: () => ChallengeDifficulty.toChallengeDifficulty(challenge),
            text: '챌린지 하러가기',
            stretch: true,
            constraints: const BoxConstraints(maxWidth: 340.0),
          ),
        ),
      ],
    );
  }
}