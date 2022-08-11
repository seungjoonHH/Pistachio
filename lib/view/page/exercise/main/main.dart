import 'package:dotted_border/dotted_border.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/page/exercise/main.dart';
import 'package:pistachio/view/page/exercise/main/widget.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ExerciseMainPage extends StatelessWidget {
  const ExerciseMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const HomeAppBar(),
      body: GetBuilder<ExerciseMain>(
          builder: (controller) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      height: 91.0,
                    ),
                    if (controller.state != ExerciseState.unselected)
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      width: 330.0,
                      height: 91.0,
                      child: Card(
                        color: const Color(0xfffbf8f1),
                        child: Row(
                          children: [
                            Container(
                              width: 100.0,
                              height: 100.0,
                              padding: const EdgeInsets.all(5.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                ),
                              ),
                              child: SvgPicture.asset('assets/image/object/whale.svg'),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('진행 중인 챌린지', style: TextStyle(fontSize: 12.0)),
                                    const Text('향고래 구출하기', style: TextStyle(fontSize: 22.0)),
                                    Expanded(
                                      child: LinearPercentIndicator(
                                        percent: .6,
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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const SizedBox(height: 350.0),
                    if (controller.state == ExerciseState.unselected)
                    Center(
                      child: DottedBorder(
                        borderType: BorderType.Circle,
                        dashPattern: const [10.0, 10.0],
                        strokeWidth: 5.0,
                        color: const Color(0xff54bab9),
                        child: Container(
                          width: 300.0,
                          height: 300.0,
                          child: const Center(
                            child: Text('운동을\n설정해주세요',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 40.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (controller.state == ExerciseState.stop)
                    Center(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        decoration: const BoxDecoration(
                          color: Color(0xff006a69),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text('스쿼트',
                            style: TextStyle(
                              color: Color(0xfff7ecde),
                              fontSize: 50.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (controller.state == ExerciseState.ready)
                    Center(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        decoration: const BoxDecoration(
                          color: Color(0xff006a69),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${controller.second}',
                            style: const TextStyle(
                              color: Color(0xfff7ecde),
                              fontSize: 120.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (controller.state == ExerciseState.ongoing
                        || controller.state == ExerciseState.pause)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: CircularPercentIndicator(
                            radius: 155.0,
                            lineWidth: 5.0,
                            percent: (controller.exerciseTimer?.tick ?? .0)
                                % (ExerciseMain.exerciseTime * 100)
                                / (ExerciseMain.exerciseTime * 100),
                            progressColor: const Color(0xff54bab9),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Center(
                          child: Material(
                            borderRadius: BorderRadius.circular(150.0),
                            color: const Color(0xffe9dac1),
                            child: SizedBox(
                              width: 300.0,
                              height: 300.0,
                              child: Center(
                                child: SvgPicture.asset(
                                  ExerciseMain.assets[controller.assetIndex],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    const SizedBox(height: 50.0),
                    if (controller.state == ExerciseState.pause
                        || controller.state == ExerciseState.ongoing)
                    Text('개수: ${controller.count}'),
                  ],
                ),
                if (controller.state == ExerciseState.unselected
                    || controller.state == ExerciseState.stop)
                Column(
                  children: [
                    if (controller.state != ExerciseState.unselected)
                    FWButton(
                      onPressed: controller.startExercise,
                      text: '운동하기',
                    ),
                    const SizedBox(height: 20.0),
                    const FWDirectButton(
                      onPressed: ExerciseMain.toExerciseTypeSetting,
                      text: '운동 설정하기',
                    ),
                  ],
                ),
                Stack(
                  children: [
                    const SizedBox(height: 114.0),
                    if (controller.state == ExerciseState.ongoing)
                    CircledButton(
                      text: '일시정지',
                      onPressed: controller.pauseExercise,
                      color: const Color(0xfff5be48),
                    ),
                    if (controller.state == ExerciseState.pause)
                    DraggableCircledButton(
                      text: '재개',
                      color: const Color(0xfff5be48),
                      onPressed: controller.startExercise,
                      leftText: '초기화',
                      leftColor: const Color(0xffba1a1a),
                      leftSelected: controller.stopExercise,
                      rightText: '완료',
                      rightColor: const Color(0xff54bab9),
                      rightSelected: controller.finishExercise,
                    ),
                  ],
                ),
              ],
            );
          }
      ),
    );
  }
}