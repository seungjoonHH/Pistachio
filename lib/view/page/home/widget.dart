import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/page/home.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/card.dart';
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
      color: PTheme.dessertGold,
      onPressed: onPressed,
    );
  }
}


class HomeRandomCard extends StatelessWidget {
  const HomeRandomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PCard(
      color: const Color(0xFF68DAD3),
      stretch: true,
      onPressed: () {},
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PText('수명이 99초 연장되었어요',
                style: textTheme.titleLarge,
                color: PTheme.white,
                border: true,
              ),
              PText('1층 당 3초의 수명이 연장되어요.',
                style: textTheme.labelMedium,
                color: PTheme.white,
                border: true,
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
          stretch: true,
          color: const Color(0xFFE9D0C3),
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  DailyActivityCircularGraph(recordType: ActivityType.distance),
                  DailyActivityCircularGraph(recordType: ActivityType.height),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  DailyActivityCircularGraph(recordType: ActivityType.weight),
                  DailyActivityCircularGraph(recordType: ActivityType.calorie),
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
    required this.recordType,
  }) : super(key: key);

  final ActivityType recordType;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePresenter>(
      builder: (controller) {
        return Column(
          children: [
            PCircularIndicator(
              percent: .5,
              centerText: recordType.kr,
              color: recordType.color,
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                PText('250', color: PTheme.brickRed, style: textTheme.labelLarge),
                PText(
                  '/${controller.myGoals[recordType]} ${recordType.unit}',
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
            SeeMoreButton(onPressed: () {}),
          ],
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ActivityType.values.length,
          itemBuilder: (_, index) => MonthlyQuestProgressWidget(
            recordType: ActivityType.values[index],
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
    required this.recordType,
  }) : super(key: key);

  final ActivityType recordType;

  @override
  Widget build(BuildContext context) {
    const String directory = 'assets/image/page/home/';
    const Map<ActivityType, String> assets = {
      ActivityType.distance: '${directory}running.svg',
      ActivityType.height: '${directory}stairs.svg',
      ActivityType.weight: '${directory}dumbbell.svg',
      ActivityType.calorie: '${directory}lightning.svg',
    };
    Border border = Border.all(
      color: PTheme.black,
      width: 1.5,
    );
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
            child: SvgPicture.asset(assets[recordType]!),
          ),
          const VerticalDivider(
            color: PTheme.black,
            width: 0.0,
            thickness: 1.5,
          ),
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                LinearPercentIndicator(
                  padding: const EdgeInsets.only(left: 1.0),
                  progressColor: recordType.color,
                  lineHeight: double.infinity,
                  backgroundColor: Colors.transparent,
                  percent: .55,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PText(recordType.kr,
                        style: textTheme.titleMedium,
                      ),
                      PText('55%',
                        style: textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
          stretch: true,
          color: PTheme.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CollectionWidget(),
              CollectionWidget(),
              CollectionWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class CollectionWidget extends StatelessWidget {
  const CollectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          decoration: const ShapeDecoration(
            color: PTheme.grey,
            shape: PolygonBorder(
              sides: 6,
              side: BorderSide(width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        PText('부지런맨\n(움직이기)',
          maxLines: 2,
          align: TextAlign.center,
        ),
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: PTheme.black, width: 1.5),
          ),
          child: PText('15', border: true),
        ),
      ],
    );
  }
}
