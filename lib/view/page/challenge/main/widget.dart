/* 챌린지 메인 위젯 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/page/challenge/detail.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/collection.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:pistachio/view/widget/widget/card.dart';

// 챌린지 메인 리스트 뷰
class ChallengeListView extends StatelessWidget {
  const ChallengeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: ChallengePresenter.challenges.map((ch) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: ChallengeCard(challenge: ch),
        )).toList(),
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
    return PCard(
      color: PTheme.offWhite,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Image.asset(
            challenge.imageUrls['default'],
            fit: BoxFit.fitWidth,
          ),
          const Divider(height: 1.0, color: PTheme.black, thickness: 1.5),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        PText(challenge.title ?? '',
                          style: textTheme.titleLarge,
                          color: PTheme.black,
                          maxLines: 2,
                        ),
                        PText('8/1~8/31',
                          style: textTheme.labelLarge,
                          color: PTheme.black,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    CollectionWidget(
                      collection: challenge.collections[Difficulty.hard],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                PText(challenge.descriptions['sub']!,
                  style: textTheme.titleSmall,
                  color: PTheme.black,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          PButton(
            onPressed: () => ChallengeDetail.toChallengeDetail(challenge),
            text: '알아보러 가기',
            stretch: true,
          ),
        ],
      ),
    );
  }
}
