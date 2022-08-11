import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/page/record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyRecordView extends StatelessWidget {
  const MyRecordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 33.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "오늘의 기록",
            style: textTheme.labelLarge,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            width: 330.0,
            height: 110.0,
            child: Card(
              color: const Color(0xfffbf8f1),
              child: InkWell(
                onTap: RecordPresenter.toRecordDetail,
                borderRadius: BorderRadius.circular(10.0),
                child: Row(
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      padding: const EdgeInsets.all(5.0),
                      decoration: const BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: SvgPicture.asset('assets/image/object/moai_stone.svg'),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('오늘 들은 무게', style: TextStyle(fontSize: 12.0)),
                            const Text('모아이 석상', style: TextStyle(fontSize: 22.0)),
                            const Text('다음 단계 : 코끼리 까지', style: TextStyle(fontSize: 12.0)),
                            Expanded(
                              child: LinearPercentIndicator(
                                percent: .6,
                                lineHeight: 12.0,
                                padding: EdgeInsets.zero,
                                barRadius: const Radius.circular(6.0),
                                progressColor: const Color(0xff54bab9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            width: 330.0,
            height: 110.0,
            child: Card(
              color: const Color(0xfffbf8f1),
              child: Row(
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    padding: const EdgeInsets.all(5.0),
                    decoration: const BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                    child: SvgPicture.asset('assets/image/object/namhansanseong.svg'),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('오늘 이동한 거리', style: TextStyle(fontSize: 12.0)),
                          const Text('남한산성', style: TextStyle(fontSize: 22.0)),
                          const Text('다음 단계 : 마라톤 풀코스 까지', style: TextStyle(fontSize: 12.0)),
                          Expanded(
                            child: LinearPercentIndicator(
                              percent: .9,
                              padding: EdgeInsets.zero,
                              lineHeight: 12.0,
                              barRadius: const Radius.circular(6.0),
                              progressColor: const Color(0xff54bab9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            width: 330.0,
            height: 110.0,
            child: Card(
              color: const Color(0xfffbf8f1),
              child: Row(
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    padding: const EdgeInsets.all(5.0),
                    decoration: const BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                    child: SvgPicture.asset('assets/image/object/eiffel_tower.svg'),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('오늘 오른 계단 높이', style: TextStyle(fontSize: 12.0)),
                          const Text('에펠탑', style: TextStyle(fontSize: 22.0)),
                          const Text('다음 단계 : 엠파이어 스테이트 빌딩 까지', style: TextStyle(fontSize: 12.0)),
                          Expanded(
                            child: LinearPercentIndicator(
                              percent: .2,
                              padding: EdgeInsets.zero,
                              lineHeight: 12.0,
                              barRadius: const Radius.circular(6.0),
                              progressColor: const Color(0xff54bab9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class RecordCard extends StatelessWidget{
  final double rate;
  final String measure;
  final String currentLevel;
  final String nextLevel;
  final String image;

  const RecordCard({
    Key? key,
    required this.rate,
    required this.measure,
    required this.currentLevel,
    required this.nextLevel,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percent = rate;
    if (rate == .0) percent = .05;

    return InkWell(
      onTap: RecordPresenter.toRecordDetail,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0, top: 14.0),
        decoration: BoxDecoration(
          color: FWTheme.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 104,
              height: 112,
              color: FWTheme.white,
              child: SvgPicture.asset(image),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(measure),
                Text(currentLevel,
                  style: textTheme.titleLarge,
                ),
                Container(
                    padding: const EdgeInsets.only(top:18),
                    child: Text("다음 단계: $nextLevel 까지")
                ),
                Container(
                  width: 250,
                  padding: const EdgeInsets.all(1.0),

                  decoration: BoxDecoration(
                    //border: Border.all(color: Theme.of(context).colorScheme.outline),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: LinearPercentIndicator(
                    padding: EdgeInsets.zero,
                    lineHeight: 10,
                    backgroundColor: const Color(0xffD9D9D9),
                    progressColor: const Color(0xff54BAB9).withOpacity(.3 + percent * 7 / 10),
                    barRadius: const Radius.circular(10.0),
                    percent: percent,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}



