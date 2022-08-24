/* 챌린지 메인 위젯 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/challenge/detail.dart';
import 'package:pistachio/presenter/page/challenge/main.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/collection.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:pistachio/view/widget/widget/card.dart';


class ChallengeMainView extends StatelessWidget {
  const ChallengeMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChallengeTabBar(),
        ChallengeTabView(),
      ],
    );
  }
}

class ChallengeTabBar extends StatelessWidget {
  const ChallengeTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChallengeMain>();

    return TabBar(
      controller: controller.tabCont,
      tabs: controller.tabs,
      indicatorColor: PTheme.black,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 1.5,
      labelPadding: const EdgeInsets.all(5.0),
      splashFactory: InkRipple.splashFactory,
    );
  }
}


class ChallengeTabView extends StatelessWidget {
  const ChallengeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChallengeMain>();

    return Expanded(
      child: TabBarView(
        controller: controller.tabCont,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ChallengeListView(),
          MyChallengeListView(),
        ],
      ),
    );
  }
}


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
            iconTheme: const IconThemeData(color: PTheme.white),
            backgroundColor: PTheme.background,
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
      color: PTheme.background,
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
                      size: 80.0,
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

class MyChallengeListView extends StatelessWidget {
  const MyChallengeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserPresenter>();

    return ListView.separated(
      shrinkWrap: true,
      itemCount: controller.myParties.length,
      padding: const EdgeInsets.all(20.0),
      itemBuilder: (_, index) => MyChallengeListTile(
        challenge: controller.myParties.values.toList()[index].challenge!,
      ),
      separatorBuilder: (_, index) => const SizedBox(height: 20.0),
    );
  }
}

class MyChallengeListTile extends StatelessWidget {
  const MyChallengeListTile({
    Key? key,
    required this.challenge,
  }) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: PTheme.black),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: AspectRatio(
          aspectRatio: 1.0,
          child: Image.asset(
            challenge.imageUrls['focus'],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
