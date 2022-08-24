import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/quest.dart';
import 'package:pistachio/presenter/page/home.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/card.dart';
import 'package:pistachio/view/widget/widget/collection.dart';
import 'package:pistachio/view/widget/widget/indicator.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            HomeRandomCard(),
            SizedBox(height: 30.0),
            DailyActivityCardView(),
            SizedBox(height: 30.0),
            MonthlyQuestWidget(),
            SizedBox(height: 30.0),
            CollectionCardView(),
          ],
        ),
      ),
    );
  }
}

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PTextButton(
      text: '더 보기',
      color: PTheme.colorC,
      onPressed: onPressed,
    );
  }
}

class HomeRandomCard extends StatelessWidget {
  const HomeRandomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PCard(
      color: PTheme.white,
      rounded: true,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PText(
                '수명이 99초 연장되었어요',
                style: textTheme.titleLarge,
                color: PTheme.black,
              ),
              const SizedBox(height: 10.0),
              PText(
                '1층 당 3초의 수명이 연장되어요.',
                style: textTheme.labelMedium,
                color: PTheme.black,
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                'assets/image/page/home/heartbeat.svg',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DailyActivityCardView extends StatelessWidget {
  const DailyActivityCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PText('오늘의 활동', style: textTheme.titleMedium),
            SeeMoreButton(onPressed: () {}),
          ],
        ),
        PCard(
          color: const Color(0xFFE9D0C3),
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  DailyActivityCircularGraph(type: ActivityType.distance),
                  DailyActivityCircularGraph(type: ActivityType.height),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  DailyActivityCircularGraph(type: ActivityType.weight),
                  DailyActivityCircularGraph(type: ActivityType.calorie),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DailyActivityCircularGraph extends StatelessWidget {
  const DailyActivityCircularGraph({
    Key? key,
    required this.type,
  }) : super(key: key);

  final ActivityType type;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePresenter>(
      builder: (controller) {
        int todayRecord = controller.todayRecords[type] ?? 0;
        int goal = controller.myGoals[type] ?? 1;

        double earlierPercent = min(todayRecord / goal, 1);
        double laterPercent = max(min(todayRecord - goal, goal) / goal, 0);
        double totalPercent = max(earlierPercent + laterPercent, .0001);

        const int totalDuration = 1500;
        int earlierDuration = totalDuration * earlierPercent ~/ totalPercent;
        if (laterPercent == 0) earlierDuration = totalDuration;
        int laterDuration = totalDuration * laterPercent ~/ totalPercent;

        return Column(
          children: [
            Stack(
              children: [
                PCircularPercentIndicator(
                  percent: earlierPercent,
                  centerText: type.kr,
                  color: type.color,
                  duration: earlierDuration,
                  onAnimationEnd: () => controller.showLaterGraph(type),
                ),
                PCircularPercentIndicator(
                  visible: controller.graphStates[type]!,
                  percent: laterPercent,
                  centerText: type.kr,
                  duration: laterDuration,
                  color: PTheme.white.withOpacity(.3),
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                PText(
                  '$todayRecord',
                  color: PTheme.colorB,
                  style: textTheme.labelLarge,
                ),
                PText(
                  '/$goal ${type.unit}',
                  style: textTheme.labelLarge,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class MonthlyQuestWidget extends StatelessWidget {
  const MonthlyQuestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PText('월간 목표', style: textTheme.titleMedium),
            SeeMoreButton(
              onPressed: () {
                Get.toNamed('/quest');
              },
            ),
          ],
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ActivityType.values.length,
          itemBuilder: (_, index) => MonthlyQuestProgressWidget(
            type: ActivityType.values[index],
          ),
          separatorBuilder: (_, index) => const SizedBox(height: 20.0),
        ),
      ],
    );
  }
}

class MonthlyQuestProgressWidget extends StatelessWidget {
  const MonthlyQuestProgressWidget({
    Key? key,
    required this.type,
  }) : super(key: key);

  final ActivityType type;

  @override
  Widget build(BuildContext context) {
    const String directory = 'assets/image/page/home/';
    Border border = Border.all(color: PTheme.black, width: 1.5);

    return Container(
      decoration: BoxDecoration(
        border: border,
        color: colorScheme.surface,
      ),
      height: 80.0,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset('$directory${type.asset}'),
          ),
          const VerticalDivider(
            color: PTheme.black,
            width: 0.0,
            thickness: 1.5,
          ),
          Expanded(
            flex: 3,
            child: GetBuilder<HomePresenter>(builder: (controller) {
              int record = controller.thisMonthRecords[type] ?? 0;
              int goal = QuestPresenter.quests[type] ?? 1;
              if (type == ActivityType.weight) goal ~/= weight + 1;
              double percent = min(record / goal, 1);

              return Stack(
                children: [
                  LinearPercentIndicator(
                    padding: const EdgeInsets.only(left: 1.0),
                    progressColor: type.color,
                    lineHeight: double.infinity,
                    backgroundColor: Colors.transparent,
                    percent: percent,
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PText(
                            type.kr,
                            style: textTheme.titleMedium,
                          ),
                          PText(
                            '${(percent * 100).ceil()} %',
                            style: textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class CollectionCardView extends StatelessWidget {
  const CollectionCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PText('컬렉션', style: textTheme.titleMedium),
            SeeMoreButton(onPressed: () {}),
          ],
        ),
        PCard(
          color: PTheme.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CollectionWidget(detail: true),
              CollectionWidget(detail: true),
              CollectionWidget(detail: true),
            ],
          ),
        ),
      ],
    );
  }
}
