import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/number.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/quest.dart';
import 'package:pistachio/presenter/page/home.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/card.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class MonthlyQuestView extends StatelessWidget {
  const MonthlyQuestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PCard(
            color: PTheme.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText(
                  '${today.month}월의 목표',
                  style: textTheme.headlineSmall,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      BadgeWidget(size: 60.0),
                      BadgeWidget(),
                      BadgeWidget(size: 60.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(thickness: 2.0, color: PTheme.black, height: 5.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PText('이달의 목표',
                      style: textTheme.headlineSmall,
                    ),
                    PText(
                      '월간 목표 달성으로 자신의 한계에 도전해 보세요.\n이번 ${DateTime.now().month}월의 목표를 달성하시면 특별 뱃지를 획득 하실 수 있습니다.',
                      style: textTheme.bodySmall,
                      color: PTheme.outline,
                      maxLines: 3,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ActivityType.activeValues.map((type) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BadgeWidget(size: 60.0),
                        QuestPercentView(type: type),
                      ],
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class QuestPercentView extends StatelessWidget {
  final ActivityType type;

  const QuestPercentView({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestPresenter>(
      builder: (controller) {
        final homePresenter = Get.find<HomePresenter>();
        int record = homePresenter.thisMonthRecords[type] ?? 0;
        int goal = QuestPresenter.quests[type] ?? 1;
        if (type == ActivityType.weight) goal ~/= weight + 1;
        double percent = min(record / goal, 1);

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PTexts(['${toLocalString(goal)}${type.unit}', type.verb],
                  colors: [type.color, PTheme.black],
                  alignment: MainAxisAlignment.start,
                ),
                const SizedBox(height: 5.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: PTheme.black, width: 1.5),
                  ),
                  child: LinearPercentIndicator(
                    padding: EdgeInsets.zero,
                    progressColor: type.color,
                    lineHeight: 21.0,
                    backgroundColor: PTheme.bar,
                    center: PText(
                      '${toLocalString(record)} / ${toLocalString(goal)} ${type.unit}',
                      style: textTheme.labelSmall,
                    ),
                    percent: percent,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
