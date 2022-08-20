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
              border: true,
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
        color: PTheme.offWhite,
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  challenge.imageUrls['default'],
                  height: 206.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 0.0, 0.0),
                  child: PText('향고래에게\n 무슨 일이?',
                    style: textTheme.headlineLarge,
                    color: PTheme.black,
                    maxLines: 2,
                    border: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                  child: PText(
                    challenge.descriptions['sub']!.replaceAll('#', ''),
                    style: textTheme.titleSmall,
                    color: PTheme.black,
                    maxLines: 2,
                  ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 70.0, vertical: 5.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
