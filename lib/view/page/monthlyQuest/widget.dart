import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../global/theme.dart';
import '../../widget/widget/text.dart';

class MonthlyQuestView extends StatelessWidget {
  const MonthlyQuestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: const ShapeDecoration(
                          color: PTheme.grey,
                          shape: PolygonBorder(
                            sides: 6,
                            side: BorderSide(width: 1.5),
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text('1000회'),
                        ),
                      ),
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
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text('10만보'),
                        ),
                      ),
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: const ShapeDecoration(
                          color: PTheme.grey,
                          shape: PolygonBorder(
                            sides: 6,
                            side: BorderSide(width: 1.5),
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text('500층'),
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
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: const ShapeDecoration(
                      color: PTheme.grey,
                      shape: PolygonBorder(
                        sides: 6,
                        side: BorderSide(width: 1.5),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('10만보 걷기를 성공하세요'),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 30.0,
                              child: LinearPercentIndicator(
                                padding: const EdgeInsets.only(left: 1.0),
                                progressColor: Colors.red,
                                lineHeight: double.infinity,
                                backgroundColor: Colors.tealAccent,
                                center: PText(
                                  '23,567/100,000 보',
                                  style: textTheme.titleMedium,
                                ),
                                percent: 0.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: const ShapeDecoration(
                      color: PTheme.grey,
                      shape: PolygonBorder(
                        sides: 6,
                        side: BorderSide(width: 1.5),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('10만보 걷기를 성공하세요'),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 30.0,
                              child: LinearPercentIndicator(
                                padding: const EdgeInsets.only(left: 1.0),
                                progressColor: Colors.red,
                                lineHeight: double.infinity,
                                backgroundColor: Colors.tealAccent,
                                center: PText(
                                  '23,567/100,000 보',
                                  style: textTheme.titleMedium,
                                ),
                                percent: 0.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: const ShapeDecoration(
                      color: PTheme.grey,
                      shape: PolygonBorder(
                        sides: 6,
                        side: BorderSide(width: 1.5),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('10만보 걷기를 성공하세요'),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 30.0,
                              child: LinearPercentIndicator(
                                padding: const EdgeInsets.only(left: 1.0),
                                progressColor: Colors.red,
                                lineHeight: double.infinity,
                                backgroundColor: Colors.tealAccent,
                                center: PText(
                                  '23,567/100,000 보',
                                  style: textTheme.titleMedium,
                                ),
                                percent: 0.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
