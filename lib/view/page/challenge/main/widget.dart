/* 챌린지 메인 위젯 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/page/challenge/detail.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:pistachio/view/widget/widget/card.dart';

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
class ChallengeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChallengeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChallengePresenter>(
        builder: (controller) {
          return AppBar(
            elevation: 0.0,
            iconTheme: const IconThemeData(color: PTheme.light),
            backgroundColor: PTheme.offWhite,
            title: PText('챌린지',
              style: textTheme.headlineMedium,
            ),
          );
        }
    );
  }
}

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({Key? key, required this.challenge}) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: PCard(
        color: challenge.theme['background'],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    challenge.imageUrls['default'],
                    height: 206.0,
                  ),
                  PText('이번주의\n첼린지',
                    style: textTheme.headlineLarge,
                    color: PTheme.white,
                    maxLines: 2,
                    border: true,
                  ),
                  PText(
                    challenge.descriptions['sub']!.replaceAll('#', ''),
                    style: textTheme.titleSmall,
                    color: PTheme.white,
                    maxLines: 2,
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PButton(
                    onPressed: () => ChallengeDetail.toChallengeDetail(challenge),
                    text: '알아보러 가기',
                    color: challenge.theme['button'],
                    padding: EdgeInsets.symmetric(
                      horizontal: 70.0, vertical: 5.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
