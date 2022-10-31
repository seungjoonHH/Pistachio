import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/model/collection.dart';
import 'package:pistachio/presenter/model/quest.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/collection/main.dart';
import 'package:pistachio/presenter/page/home.dart';
import 'package:pistachio/presenter/page/quest.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/card.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/indicator.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeRandomCardView(),
          Column(
            children: const [
              SizedBox(height: 30.0),
              DailyActivityCardView(),
              SizedBox(height: 30.0),
              MonthlyQuestWidget(),
              SizedBox(height: 30.0),
              CollectionCardView(),
              SizedBox(height: 30.0),
            ],
          ),
        ],
      ),
    );
  }
}

class WidgetHeader extends StatelessWidget {
  const WidgetHeader({
    Key? key,
    this.isIconButton = false,
    required this.title,
    required this.pressedAction,
  }) : super(key: key);

  final bool isIconButton;
  final String title;
  final VoidCallback pressedAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PText(title, style: textTheme.headlineSmall),
          isIconButton
              ? EditButton(onPressed: pressedAction)
              : SeeMoreButton(onPressed: pressedAction),
        ],
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: onPressed,
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

class HomeRandomCardView extends StatelessWidget {
  const HomeRandomCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      const QuestRecommendCard(),
      const LifeExtensionCard(),
    ]
        .map((widget) => Padding(
              padding: EdgeInsets.fromLTRB(20.0.r, 20.0.r, 20.0.r, 0.0.r),
              child: widget,
            ))
        .toList();

    items.shuffle();

    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: 230.0.h,
        viewportFraction: 1.0,
        autoPlay: true,
      ),
    );
  }
}

class QuestRecommendCard extends StatelessWidget {
  const QuestRecommendCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PCard(
      color: PTheme.white,
      onPressed: QuestMain.toQuestMain,
      rounded: true,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PText(
                '${today.month}월의 목표',
                style: textTheme.titleLarge,
                color: PTheme.black,
              ),
              SizedBox(height: 10.0.h),
              PText(
                '를 달성하고 컬렉션을 모아보세요.',
                style: textTheme.labelMedium,
                color: PTheme.grey,
              ),
            ],
          ),
          SizedBox(height: 20.0.h),
          SizedBox(
            height: 80.0.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BadgeWidget(
                  badge: BadgePresenter.getBadge(
                      '10401${(today.month - 1).toString().padLeft(2, '0')}'),
                  size: 60.0,
                ),
                BadgeWidget(
                  badge: BadgePresenter.getBadge(
                      '10400${(today.month - 1).toString().padLeft(2, '0')}'),
                ),
                BadgeWidget(
                  badge: BadgePresenter.getBadge(
                      '10402${(today.month - 1).toString().padLeft(2, '0')}'),
                  size: 60.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LifeExtensionCard extends StatelessWidget {
  const LifeExtensionCard({Key? key}) : super(key: key);

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
              SizedBox(height: 10.0.h),
              PText(
                '1층 당 3초의 수명이 연장되어요.',
                style: textTheme.labelMedium,
                color: PTheme.grey,
              ),
            ],
          ),
          SizedBox(height: 20.0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                'assets/image/page/home/heartbeat.svg',
                height: 80.0.h,
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
        WidgetHeader(isIconButton: true, title: '오늘 활동량', pressedAction: () {}),
        SizedBox(height: 10.0.h),
        PCard(
          padding: EdgeInsets.zero,
          borderType: BorderType.horizontal,
          borderWidth: 3.0,
          color: PTheme.surface,
          child: GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
            ),
            children: ActivityType.values
                .map((type) => DailyActivityCircularGraph(type: type))
                .toList(),
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

        return Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    PCircularPercentIndicator(
                      percent: earlierPercent,
                      backgroundColor: PTheme.bar,
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
                PTexts(
                  ['$todayRecord', '/$goal ${type.unit}'],
                  colors: [type.color, PTheme.black],
                  style: textTheme.labelLarge,
                  space: false,
                ),
              ],
            ),
            if (!type.active)
              Positioned.fill(
                child: Stack(
                  children: [
                    Container(
                      color: PTheme.surface,
                      alignment: Alignment.center,
                      child: Icon(Icons.lock, size: 30.0.r),
                    ),
                    Container(
                      color: PTheme.black.withOpacity(.3),
                    ),
                  ],
                ),
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
        const WidgetHeader(
            title: '월간 목표', pressedAction: QuestMain.toQuestMain),
        const SizedBox(height: 10.0),
        Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: PTheme.black,
                width: 2.5,
              ),
            ),
          ),
          child: Column(
            children: ActivityType.values
                .map((type) => MonthlyQuestProgressWidget(
                      type: type,
                    ))
                .toList(),
          ),
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

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: PTheme.black,
                width: .5,
              ),
            ),
          ),
          height: 80.0,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: PTheme.surface,
                  child: SvgPicture.asset('$directory${type.asset}'),
                ),
              ),
              const VerticalDivider(
                color: PTheme.black,
                width: 0.0,
                thickness: 1.0,
              ),
              Expanded(
                flex: 3,
                child: GetBuilder<HomePresenter>(
                  builder: (controller) {
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
                          backgroundColor: PTheme.surface,
                          percent: percent < .01 ? .01 : percent,
                        ),
                        Center(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
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
                  },
                ),
              ),
            ],
          ),
        ),
        if (!type.active)
          Positioned.fill(
            child: Stack(
              children: [
                Container(
                  color: PTheme.surface,
                  alignment: Alignment.center,
                  child: Icon(Icons.lock, size: 30.0.r),
                ),
                Container(
                  color: PTheme.black.withOpacity(.3),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class CollectionCardView extends StatelessWidget {
  const CollectionCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userPresenter = Get.find<UserPresenter>();

    List<Widget> collectionWidgets =
        List.generate(3, (_) => const CollectionWidget());
    for (int i = 0; i < userPresenter.myCollections.length; i++) {
      Collection collection = userPresenter.myCollections[i];
      collectionWidgets[i] = CollectionWidget(
        onPressed: () => GlobalPresenter.showCollectionDialog(collection),
        collection: collection,
        detail: true,
      );
    }

    return Column(
      children: [
        const WidgetHeader(
          title: '컬렉션',
          pressedAction: CollectionMain.toCollectionMain,
        ),
        const SizedBox(height: 10.0),
        PCard(
          borderType: BorderType.horizontal,
          borderWidth: 3.0,
          color: PTheme.surface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: collectionWidgets,
          ),
        ),
      ],
    );
  }
}
