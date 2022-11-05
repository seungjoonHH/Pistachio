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
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/model/badge.dart';
import 'package:pistachio/presenter/model/quest.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/collection/main.dart';
import 'package:pistachio/presenter/page/home.dart';
import 'package:pistachio/presenter/page/quest.dart';
import 'package:pistachio/presenter/widget/loading.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/card.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/indicator.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../presenter/page/editGoal.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePresenter>(builder: (homeP) {
      return GetBuilder<LoadingPresenter>(
        builder: (loadingP) {
          return SmartRefresher(
            controller: HomePresenter.refreshCont,
            onRefresh: () async {
              loadingP.loadStart();
              await homeP.init();
              loadingP.loadEnd();
              HomePresenter.refreshCont.refreshCompleted();
            },
            onLoading: () async {
              await Future.delayed(const Duration(milliseconds: 100));
              HomePresenter.refreshCont.loadComplete();
            },
            header: const MaterialClassicHeader(
              color: PTheme.black,
              backgroundColor: PTheme.surface,
            ),
            child: SingleChildScrollView(
              child: !loadingP.loading
                  ? Column(
                      children: [
                        const HomeRandomCardView(),
                        Column(
                          children: [
                            SizedBox(height: 30.0.h),
                            const DailyActivityCardView(),
                            SizedBox(height: 30.0.h),
                            const MonthlyQuestWidget(),
                            SizedBox(height: 30.0.h),
                            const CollectionCardView(),
                            SizedBox(height: 30.0.h),
                          ],
                        ),
                      ],
                    )
                  : HomeLoading(color: loadingP.color),
            ),
          );
        },
      );
    });
  }
}

class WidgetHeader extends StatelessWidget {
  const WidgetHeader({
    Key? key,
    this.isEditGoal = false,
    required this.title,
    this.seeMorePressed,
  }) : super(key: key);

  final bool isEditGoal;
  final String title;
  final VoidCallback? seeMorePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 40.0.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PText(title, style: textTheme.headlineSmall),
          if (seeMorePressed != null)
            isEditGoal
                ? EditGoalButton(onPressed: seeMorePressed!)
                : SeeMoreButton(onPressed: seeMorePressed!),
        ],
      ),
    );
  }
}

class EditGoalButton extends StatelessWidget {
  const EditGoalButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      color: PTheme.colorC,
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
    PUser user = Get.find<UserPresenter>().loggedUser;

    List<Widget> items = [
      const QuestRecommendCard(),
      const LifeExtensionCard(),
      if (ignoreTime(user.regDate!) != today) const YesterdayComparisonCard(),
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
              PTexts(
                ['${today.month}월', '의 목표'],
                colors: const [PTheme.colorA, PTheme.black],
                style: textTheme.titleLarge,
                alignment: MainAxisAlignment.start,
                space: false,
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
    final userP = Get.find<UserPresenter>();
    PUser user = userP.loggedUser;
    double todayHeights = user.getTodayAmounts(ActivityType.height);
    double lifeExtension = 100 * todayHeights;
    String string = timeToString(lifeExtension.ceil());

    if (lifeExtension >= 60 * 60 * 24) {
      string = '약 ${timeToString((lifeExtension ~/ 3600) * 3600)}';
    } else if (lifeExtension >= 60 * 60) {
      string = '약 ${timeToString((lifeExtension ~/ 60) * 60)}';
    }
    return PCard(
      color: PTheme.white,
      rounded: true,
      child: Column(
        children: [
          if (todayHeights == 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PText(
                  '계단을 올라 수명을 연장해보세요',
                  style: textTheme.titleLarge,
                ),
                SizedBox(height: 10.0.h),
                PText(
                  '한 층을 오르면 수명이 1분 40초 늘어나요!',
                  style: textTheme.labelMedium,
                  color: PTheme.grey,
                ),
              ],
            ),
          if (todayHeights > 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PTexts(
                  ['수명이', string, '연장되었어요'],
                  colors: const [PTheme.black, PTheme.colorD, PTheme.black],
                  style: textTheme.titleLarge,
                  alignment: MainAxisAlignment.start,
                ),
                SizedBox(height: 10.0.h),
                PText(
                  '한 층을 오르면 수명이 1분 40초 늘어나요!',
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

class YesterdayComparisonCard extends StatelessWidget {
  const YesterdayComparisonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PCard(
      color: PTheme.white,
      rounded: true,
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PText('어제와 비교해서', style: textTheme.titleLarge),
                const SizedBox(height: 10.0),
                Expanded(
                  child: GetBuilder<UserPresenter>(
                    builder: (controller) {
                      Map<ActivityType, double> diffs = {};
                      Map<ActivityType, List<String>> diffMessages = {};
                      late String last;

                      for (ActivityType type in ActivityType.activeValues) {
                        double todays =
                            controller.loggedUser.getTodayAmounts(type);
                        double yesterdays = controller.loggedUser.getAmounts(
                            type, yesterday, oneSecondBefore(today));

                        double diff = todays - yesterdays;
                        diffs[type] = diff;
                        diffMessages[type] = [];

                        last = type == ActivityType.calorie
                            ? type.did
                            : '${type.and},';

                        if (diff == 0) {
                          diffMessages[type]!.addAll(['비슷하게', last]);
                          continue;
                        }
                        diffMessages[type]!
                            .add('${diff.abs().round()}${type.unit}');
                        diffMessages[type]!
                            .add('${diff > 0 ? '더' : '덜'} $last');
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              PTexts(
                                diffMessages[ActivityType.distance]!,
                                colors: const [PTheme.colorB, PTheme.black],
                                style: textTheme.titleLarge,
                                alignment: MainAxisAlignment.start,
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              PTexts(
                                diffMessages[ActivityType.height]!,
                                colors: const [PTheme.colorD, PTheme.black],
                                style: textTheme.titleLarge,
                                alignment: MainAxisAlignment.center,
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              PTexts(
                                diffMessages[ActivityType.calorie]!,
                                colors: const [PTheme.colorA, PTheme.black],
                                style: textTheme.titleLarge,
                                alignment: MainAxisAlignment.end,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
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

class DailyActivityCardView extends StatelessWidget {
  const DailyActivityCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const WidgetHeader(
          isEditGoal: true,
          title: '오늘 활동량',
          seeMorePressed: EditGoalPresenter.toEditGoal,
        ),
        SizedBox(height: 10.0.h),
        SizedBox(
          child: PCard(
            padding: EdgeInsets.zero,
            borderType: BorderType.horizontal,
            borderWidth: 3.0,
            color: PTheme.surface,
            child: GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.w / 1.h,
              ),
              children: ActivityType.values
                  .map((type) => DailyActivityCircularGraph(type: type))
                  .toList(),
            ),
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
        final userP = Get.find<UserPresenter>();
        PUser user = userP.loggedUser;

        int todayRecord = user.getTodayAmounts(type).round();
        todayRecord += user.getTodayInputAmounts(type).round();

        int goal = max((user.getGoal(type)!.amount).round(), 1);

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
                      duration: earlierDuration,
                      centerText: type.kr,
                      color: type.color,
                      textColor: type.color,
                      borderColor: PTheme.black,
                      backgroundColor: PTheme.bar,
                      onAnimationEnd: () => controller.showLaterGraph(type),
                    ),
                    PCircularPercentIndicator(
                      visible: controller.graphStates[type]!,
                      percent: laterPercent,
                      duration: laterDuration,
                      color: PTheme.white.withOpacity(.3),
                      borderColor: PTheme.black,
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
                SizedBox(height: 10.0.h),
                SizedBox(
                  height: 20.0.h,
                  child: PTexts(
                    ['$todayRecord', '/$goal ${type.unit}'],
                    colors: [type.color, PTheme.black],
                    style: textTheme.labelLarge,
                    space: false,
                  ),
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
            title: '월간 목표', seeMorePressed: QuestMain.toQuestMain),
        SizedBox(height: 10.0.h),
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
    final userP = Get.find<UserPresenter>();
    PUser user = userP.loggedUser;
    const String directory = 'assets/image/page/home/';

    double record = user.getThisMonthAmounts(type);
    int goal = QuestPresenter.quests[type] ?? 1;
    if (type == ActivityType.weight) goal ~/= weight + 1;
    double percent = min(record / goal, 1);

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
          height: 80.0.h,
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
                child: Stack(
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
    final userP = Get.find<UserPresenter>();
    PUser user = userP.loggedUser;

    List<Widget> collectionWidgets =
        List.generate(3, (_) => const CollectionWidget());
    for (int i = 0; i < min(user.collections.length, 3); i++) {
      Collection collection = user.collections[i];
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
          seeMorePressed: CollectionMain.toCollectionMain,
        ),
        SizedBox(height: 10.0.h),
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

class HomeLoading extends StatelessWidget {
  const HomeLoading({
    Key? key,
    this.color = PTheme.black,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.0.r, 20.0.r, 20.0.r, 0.0),
            child: PCard(
              color: color,
              rounded: true,
              borderColor: Colors.transparent,
              child: Container(
                height: 166.0.h,
              ),
            ),
          ),
          Container(height: 82.0.h),
          Container(
            color: color,
            height: 366.0.h,
            child: GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.w / 1.h,
              ),
              children: List.generate(
                  4,
                  (_) => Padding(
                        padding: EdgeInsets.all(20.0.r),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 112.0.r,
                                  height: 112.0.r,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: PTheme.white,
                                  ),
                                ),
                                Container(
                                  width: 112.0.r,
                                  height: 112.0.r,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: PTheme.background,
                                  ),
                                ),
                                Container(
                                  width: 76.0.r,
                                  height: 76.0.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
            ),
          ),
          SizedBox(height: 78.0.h),
          Container(
            height: 326.0.h,
            color: color,
          ),
          SizedBox(height: 78.0.h),
          PCard(
            borderType: BorderType.horizontal,
            borderWidth: 3.0,
            color: color,
            borderColor: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  3,
                  (_) => Stack(
                        children: const [
                          CollectionWidget(
                            color: PTheme.surface,
                            border: false,
                            detail: true,
                          ),
                        ],
                      )),
            ),
          ),
          SizedBox(height: 30.0.h),
        ],
      ),
    );
  }
}
