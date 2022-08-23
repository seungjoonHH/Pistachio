import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/quest.dart';
import '../../../global/theme.dart';
import '../../../global/unit.dart';
import '../../../presenter/page/home.dart';
import '../../widget/widget/text.dart';

class MonthlyQuestView extends StatelessWidget {
  const MonthlyQuestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int weightGoal = QuestPresenter.quests[ActivityType.weight] ?? 1;
    weightGoal ~/= weight + 1;
    int distanceGoal = QuestPresenter.quests[ActivityType.distance] ?? 1;
    distanceGoal ~/= 10000;
    int heightGoal = QuestPresenter.quests[ActivityType.height] ?? 1;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xffE5953E),
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText(
                  '${DateTime.now().month}월의 목표',
                  style: textTheme.headlineSmall,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Polygon(
                        size: 80.0,
                        widget: Align(
                          alignment: Alignment.center,
                          child: Text('$weightGoal${ActivityType.weight.unit}'),
                        ),
                      ),
                      Polygon(
                        size: 100.0,
                        widget: Align(
                          alignment: Alignment.center,
                          child: Text('$distanceGoal'
                              '만'
                              '${ActivityType.distance.unit}'),
                        ),
                      ),
                      Polygon(
                        size: 80.0,
                        widget: Align(
                          alignment: Alignment.center,
                          child: Text('$heightGoal${ActivityType.height.unit}'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(thickness: 2.0),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PText(
                '이달의 목표',
                style: textTheme.titleMedium,
                bold: true,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: PText(
                  '월간 목표 달성으로 자신의 한계에 도전해 보세요.\n이번 8월의 목표를 달성하시면 특별 뱃지를 획득 하실 수 있습니다.',
                  style: textTheme.bodyMedium,
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Polygon(size: 80.0),
                  MonthlyQuestGraph(type: ActivityType.distance),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Polygon(size: 80.0),
                  MonthlyQuestGraph(type: ActivityType.weight),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Polygon(size: 80.0),
                  MonthlyQuestGraph(type: ActivityType.height),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Polygon extends StatelessWidget {
  final double size;
  final Widget? widget;

  const Polygon({Key? key, required this.size, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const ShapeDecoration(
        color: PTheme.grey,
        shape: PolygonBorder(
          sides: 6,
          side: BorderSide(width: 1.5),
        ),
      ),
      child: widget,
    );
  }
}

class MonthlyQuestGraph extends StatelessWidget {
  final ActivityType type;

  const MonthlyQuestGraph({Key? key, required this.type}) : super(key: key);

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
                Row(
                  children: [
                    type == ActivityType.distance
                        ? Text(
                            '${goal ~/ 10000}만${type.unit} ${type.quest}',
                            style: TextStyle(color: type.color),
                          )
                        : Text(
                            '$goal${type.unit} ${type.quest}',
                            style: TextStyle(color: type.color),
                          ),
                    const Text('를 성공하세요'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: 30.0,
                    child: LinearPercentIndicator(
                      padding: const EdgeInsets.only(left: 1.0),
                      progressColor: Colors.red,
                      lineHeight: double.infinity,
                      backgroundColor: colorScheme.background,
                      center: PText(
                        '$record/$goal ${type.unit}',
                        style: textTheme.titleMedium,
                      ),
                      percent: percent,
                    ),
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
