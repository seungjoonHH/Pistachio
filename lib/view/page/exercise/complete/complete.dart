import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/page/complete.dart';
import 'package:pistachio/presenter/page/home.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';

class ExerciseCompletePage extends StatelessWidget {
  const ExerciseCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitween',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff54bab9),
      ),
      body: GetBuilder<CompletePresenter>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        'assets/image/page/timer/whale.svg',
                        width: 300.0,
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    Stack(
                      children: [
                        LinearPercentIndicator(
                          padding: EdgeInsets.zero,
                          percent: controller.after,
                          lineHeight: 20.0,
                          animation: true,
                          animationDuration: 3000,
                          animateFromLastPercent: true,
                          curve: Curves.fastLinearToSlowEaseIn,
                          barRadius: const Radius.circular(10.0),
                          progressColor: const Color(0xff54bab9),
                          backgroundColor: Colors.black12,
                        ),
                        LinearPercentIndicator(
                          padding: EdgeInsets.zero,
                          percent: controller.before,
                          lineHeight: 20.0,
                          barRadius: const Radius.circular(10.0),
                          progressColor: const Color(0xff54bab9),
                          backgroundColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 30.0),
                    const Text('고래는 행복해요 :)'),
                    const SizedBox(height: 50.0),
                    PButton(
                      onPressed: () {},
                      text: '      확인      ',
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      ),
      backgroundColor: const Color(0xfff7ecde),
    );
    */
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const HomeAppBar(),
      body: GetBuilder<CompletePresenter>(
        builder: (controller) {
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                SvgPicture.asset('assets/image/object/trophy.svg'),
                const SizedBox(height: 40.0),
                const Text(
                  '+302kg 달성 !',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Expanded(child: SizedBox()),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  width: 326.0,
                  height: 120.0,
                  child: Card(
                    color: const Color(0xfffbf8f1),
                    child: Row(
                      children: [
                        Container(
                          width: 100.0,
                          height: 120.0,
                          padding: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                          ),
                          child: SvgPicture.asset(
                            'assets/image/object/beach.svg',
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('진행 중인 챌린지',
                                    style: TextStyle(fontSize: 12.0)),
                                const Text('향고래 구출하기',
                                    style: TextStyle(fontSize: 22.0)),
                                AnimatedFlipCounter(
                                  value: controller.after * 100,
                                  suffix: '%',
                                  fractionDigits: 1,
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration: const Duration(milliseconds: 1000),
                                  textStyle: const TextStyle(fontSize: 13.0),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Stack(
                                      children: [
                                        LinearPercentIndicator(
                                          padding: EdgeInsets.zero,
                                          percent: controller.after,
                                          lineHeight: 12.0,
                                          animation: true,
                                          animationDuration: 3000,
                                          animateFromLastPercent: true,
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          barRadius: const Radius.circular(10.0),
                                          progressColor: const Color(0xffffdea4),
                                          backgroundColor: Colors.black12,
                                        ),
                                        LinearPercentIndicator(
                                          padding: EdgeInsets.zero,
                                          percent: controller.before,
                                          lineHeight: 12.0,
                                          barRadius: const Radius.circular(10.0),
                                          progressColor: const Color(0xff54bab9),
                                          backgroundColor: Colors.transparent,
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
                  ),
                ),
                SizedBox(
                  width: 326.0,
                  height: 120.0,
                  child: Card(
                    color:
                    Color(controller.levelUpState ? 0xff54bab9 : 0xfffbf8f1),
                    child: controller.levelUpState
                        ? Lottie.asset(
                      'assets/json/lottie/level_up.json',
                    )
                        : Row(
                      children: [
                        Container(
                          width: 100.0,
                          height: 120.0,
                          padding: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                          ),
                          child: SvgPicture.asset(
                              controller.assets[controller.assetIndex]),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('오늘 들은 무게',
                                    style: TextStyle(fontSize: 12.0)),
                                Text(
                                  controller.titles[controller.assetIndex],
                                  style: const TextStyle(fontSize: 22.0),
                                ),
                                AnimatedFlipCounter(
                                  value: controller.after2 * 100,
                                  suffix: '%',
                                  fractionDigits: 1,
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration:
                                  const Duration(milliseconds: 1000),
                                  textStyle:
                                  const TextStyle(fontSize: 13.0),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Stack(
                                      children: [
                                        LinearPercentIndicator(
                                          padding: EdgeInsets.zero,
                                          percent: controller.after2,
                                          lineHeight: 12.0,
                                          animation: true,
                                          animationDuration: 3000,
                                          animateFromLastPercent: true,
                                          curve:
                                          Curves.fastLinearToSlowEaseIn,
                                          barRadius:
                                          const Radius.circular(10.0),
                                          progressColor:
                                          const Color(0xffffdea4),
                                          backgroundColor: Colors.black12,
                                        ),
                                        LinearPercentIndicator(
                                          padding: EdgeInsets.zero,
                                          percent: controller.before2,
                                          lineHeight: 12.0,
                                          barRadius:
                                          const Radius.circular(10.0),
                                          progressColor:
                                          const Color(0xff54bab9),
                                          backgroundColor:
                                          Colors.transparent,
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
                  ),
                ),
                const SizedBox(height: 20.0),
                const PButton(
                  onPressed: HomePresenter.toHome,
                  text: '확인',
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
