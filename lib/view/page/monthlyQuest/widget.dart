import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import '../../../global/theme.dart';

class MonthlyQuestView extends StatelessWidget {
  const MonthlyQuestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xffE5953E),
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              children: [
                Text('${DateTime.now().month}월의 목표'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              ],
            ),
          ),
        ),
        const Divider(thickness: 2.0),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('이달의 목표'),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '월간 목표 달성으로 자신의 한계에 도전해 보세요. 이번8월의 목표를 달성하시면 특별 뱃지를 획득 하실 수 있습니다.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
