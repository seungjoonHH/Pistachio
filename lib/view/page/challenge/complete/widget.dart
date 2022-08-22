/* 챌린지 완료 위젯 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:pistachio/view/widget/widget/card.dart';

// 챌린지 완료 리스트 뷰
class ChallengeListView extends StatelessWidget {
  const ChallengeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<ChallengePresenter>(
        builder: (controller) {
          return Column(
            children: controller.challenges.map((ch) => ChallengeCompleteBody(
              challenge: ch
            )).toList(),
          );
        }
      ),
    );
  }
}

class ChallengeCompleteBody extends StatelessWidget {
  const ChallengeCompleteBody({Key? key, required this.challenge}) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
          child: Center(
            child: Image.asset(
              challenge.imageUrls['complete'],
              width: 500.0,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Center(
          child: PCard(
            color: PTheme.offWhite,
            padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: PText('향고래 바다로\n돌려보내기 성공!',
                    align: TextAlign.center,
                    style: textTheme.headlineLarge,
                    color: PTheme.black,
                    maxLines: 2,
                    border: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 80.0),
                  child: PText(
                    challenge.descriptions['complete']!.replaceAll('#', ''),
                    align: TextAlign.center,
                    style: textTheme.labelLarge,
                    color: PTheme.black,
                    maxLines: 8,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 60.0),
                  child: SvgPicture.asset(
                    'assets/image/page/challenge/left_wing.svg',
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
            child: Center(
              child: PButton(
                onPressed: () => ChallengePresenter.toChallengeMain(),
                text: '컬랙션 보러가기',
                //backgroundColor: challenge.theme['button'],
              ),
            )
        )
      ],
    );
  }
}
