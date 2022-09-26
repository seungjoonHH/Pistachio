/* 챌린지 메인 위젯 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallax_animation/parallax_animation.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/model/class/json/challenge.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/widget/loading.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/challenge/detail.dart';
import 'package:pistachio/presenter/page/challenge/main.dart';
import 'package:pistachio/presenter/page/challenge/party/main.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:pistachio/view/widget/widget/card.dart';

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
        title: PText('챌린지',
          border: true,
          style: textTheme.headlineMedium,
        ),
      );
    });
  }
}

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
          MyPartyListView(),
        ],
      ),
    );
  }
}

class ChallengeListView extends StatelessWidget {
  const ChallengeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoadingPresenter>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: controller.loading
              ? ChallengeCardViewLoading(color: controller.color)
              : const ChallengeCardView(),
        );
      }
    );
  }
}

class ChallengeCardView extends StatelessWidget {
  const ChallengeCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ParallaxArea(
      child: ListView.separated(
        itemCount: ChallengePresenter.challenges.length,
        itemBuilder: (_, index) {
          return ChallengeCard(
            challenge: ChallengePresenter.challenges[index],
          );
        },
        separatorBuilder: (_, index) => const SizedBox(height: 50.0),
      ),
    );
  }
}


class ChallengeCard extends StatelessWidget {
  const ChallengeCard({Key? key, required this.challenge}) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    final userPresenter = Get.find<UserPresenter>();

    return Stack(
      children: [
        PCard(
          color: PTheme.background,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              // ParallaxWidget(
              //   background: Image.asset(
              //     challenge.imageUrls['default'],
              //     fit: BoxFit.fitHeight,
              //   ),
              //   child: Container(height: 200.0),
              // ),
              Image.asset(
                challenge.imageUrls['default'],
                fit: BoxFit.fitHeight,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PText(challenge.title ?? '',
                              style: textTheme.headlineMedium,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 10.0),
                            PText('${today.month}월의 챌린지',
                              style: textTheme.labelLarge,
                              color: PTheme.grey,
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
              userPresenter.joining(challenge) ? PButton(
                onPressed: () => ChallengePartyMain.toChallengePartyMain(
                    userPresenter.joiningParty(challenge)!
                ),
                text: '챌린지 이동하기',
                stretch: true,
              ) : PButton(
                onPressed: () => ChallengeDetail.toChallengeDetail(challenge),
                text: '알아보러 가기',
                stretch: true,
              ),
            ],
          ),
        ),
        if (challenge.locked)
        Positioned.fill(
          child: Container(
            color: PTheme.black.withOpacity(.5),
            child: Icon(Icons.lock,
              color: PTheme.black.withOpacity(.3),
              size: 70.0,
            ),
          ),
        ),
      ],
    );
  }
}

class ChallengeCardViewLoading extends StatelessWidget {
  const ChallengeCardViewLoading({
    Key? key,
    this.color = PTheme.black,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 2,
      itemBuilder: (_, index) => ChallengeCardLoading(color: color),
      separatorBuilder: (_, index) => const SizedBox(height: 50.0),
    );
  }
}


class ChallengeCardLoading extends StatelessWidget {
  const ChallengeCardLoading({
    Key? key, this.color = PTheme.black,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return PCard(
      border: false,
      color: PTheme.background,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(height: 200.0, color: color),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(width: 200.0, height: 70.0, color: color),
                        const SizedBox(height: 20.0),
                        Container(width: 200.0, height: 15.0, color: color),
                      ],
                    ),
                    BadgeWidget(size: 80.0, border: false, color: color),
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(width: 200.0, height: 40.0, color: color),
              ],
            ),
          ),
          Container(width: double.infinity, height: 48.0, color: color),
        ],
      ),
    );
  }
}

class MyPartyListView extends StatelessWidget {
  const MyPartyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPresenter>(
      builder: (controller) {
        return Stack(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: controller.myParties.length,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              itemBuilder: (_, index) => MyPartyListTile(
                party: controller.myParties.values.toList()[index],
              ),
              separatorBuilder: (_, index) => const SizedBox(height: 20.0),
            ),
            const MyPartyListViewLoading(),
          ],
        );
      }
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
        onTap: () => ChallengePartyMain.toChallengePartyMain(party),
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

class MyPartyListViewLoading extends StatelessWidget {
  const MyPartyListViewLoading({
    Key? key, this.color = PTheme.black,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoadingPresenter>(
      builder: (controller) {
        controller.mainColor = color;
        return controller.loading ? ListView.separated(
          shrinkWrap: true,
          itemCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          itemBuilder: (_, index) {
            return Container(
              color: PTheme.background,
              height: 80.0,
              child: Row(
                children: [
                  Container(width: 80.0, height: 80.0, color: controller.color),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(width: 200.0, height: 20.0, color: controller.color),
                          Row(
                            children: [
                              Container(width: 80.0, height: 15.0, color: controller.color),
                              const SizedBox(width: 20.0),
                              Container(width: 100.0, height: 15.0, color: controller.color),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                    child: Icon(Icons.arrow_forward_ios, color: controller.color),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, index) => const SizedBox(height: 20.0),
        ) : Container();
      },
    );
  }
}
