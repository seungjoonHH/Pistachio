/* 챌린지 메인 위젯 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/text.dart';

// 챌린지 메인 리스트 뷰
class ChallengeListView extends StatelessWidget {
  const ChallengeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<ChallengePresenter>(
        builder: (controller) {
          return Column(
            children: controller.challenges.map((ch) => ChallengeCard(
              challenge: ch
            )).toList(),
          );
        }
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({Key? key, required this.challenge}) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 500.0,
        child: Card(
          color: challenge.theme['background'],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                    challenge.imageUrls['default'],
                    height: 220.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                PText(challenge.title!,
                  style: textTheme.headlineLarge,
                  color: PTheme.white,
                  maxLines: 2,
                ),
                const SizedBox(height: 20.0),
                PText(
                  challenge.descriptions['sub']!.replaceAll('#', ''),
                  style: textTheme.titleSmall,
                  color: PTheme.white,
                  maxLines: 2,
                ),
                const SizedBox(height: 16.0),
                PButton(
                  onPressed: () {},
                  text: '알아보러 가기',
                  color: challenge.theme['button'],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
