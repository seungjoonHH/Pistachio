/* 챌린지 메인 위젯 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/model/class/party.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/challenge/detail.dart';
import 'package:pistachio/presenter/page/challenge/main.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:pistachio/view/widget/widget/card.dart';
import '../../../../presenter/model/user.dart';

class ChallengeMainView extends StatelessWidget {
  const ChallengeMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
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
        physics: const NeverScrollableScrollPhysics(),
        children: const [
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
        children: ChallengePresenter.challenges
            .map((ch) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ChallengeCard(challenge: ch),
                ))
            .toList(),
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
    return GetBuilder<ChallengePresenter>(builder: (controller) {
      return AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: PTheme.white),
        backgroundColor: PTheme.background,
        title: PText(
          '챌린지',
          border: true,
          style: textTheme.headlineMedium,
        ),
      );
    });
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
          Hero(
            tag: challenge.id!,
            child: Image.asset(
              challenge.imageUrls['default'],
              fit: BoxFit.fitWidth,
            ),
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
                        PText(
                          challenge.title ?? '',
                          style: textTheme.titleLarge,
                          color: PTheme.black,
                          maxLines: 2,
                        ),
                        PText(
                          '8/1~8/31',
                          style: textTheme.labelLarge,
                          color: PTheme.black,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    BadgeWidget(
                      size: 80.0,
                      badge: challenge.badges[Difficulty.hard],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                PText(
                  challenge.descriptions['sub']!,
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
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20.0),
      itemBuilder: (_, index) => MyPartyListTile(
        party: controller.myParties.values.toList()[index],
      ),
      separatorBuilder: (_, index) => const SizedBox(height: 20.0),
    );
  }
}

class MyPartyListTile extends StatelessWidget {
  const MyPartyListTile({
    Key? key,
    required this.party,
  }) : super(key: key);

  final Party party;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 80.0,
          decoration: BoxDecoration(
            border: Border.all(color: PTheme.black, width: 1.5),
          ),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.asset(
                  party.challenge!.imageUrls['focus'],
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              const VerticalDivider(
                width: 1.5,
                thickness: 1.5,
                color: PTheme.black,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PText(party.challenge!.title!.replaceAll('\n', ' '),
                        style: textTheme.bodyLarge,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.people_alt, size: 14.0),
                                const SizedBox(width: 10.0),
                                PText('${party.members.length}/${
                                  party.challenge!.levels[party.difficulty.name]['maxMember']
                                }'),
                              ],
                            ),
                          ),
                          Expanded(child: PText('난이도 : ${party.difficulty.kr}')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 50.0,
                child: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
