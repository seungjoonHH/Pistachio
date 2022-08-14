/* 운동 상세 설정 페이지 위젯 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/exercise.dart';
import 'package:pistachio/presenter/model/exercise.dart';
import 'package:pistachio/presenter/page/exercise/main.dart';
import 'package:pistachio/presenter/page/exercise/setting/detail.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ExerciseImageWidget extends StatelessWidget {
  const ExerciseImageWidget({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
      padding: const EdgeInsets.all(10.0),
      color: colorScheme.background,
      child: SvgPicture.asset(exercise.imageUrl!),
    );
  }
}

class ExerciseSelectionButton extends StatelessWidget {
  const ExerciseSelectionButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.size = 80.0,
  }) : super(key: key);

  final String text;
  final Color color;
  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        fixedSize: Size(size, size),
        shape: const CircleBorder(),
      ),
      child: PText(text, style: textTheme.bodyMedium),
    );
  }
}

class ExerciseSelectionButtonView extends StatelessWidget {
  const ExerciseSelectionButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseDetailSetting>(
      builder: (controller) {
        final exercisePresenter = Get.find<ExercisePresenter>();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: exercisePresenter.exercises.map((ex) => ExerciseSelectionButton(
            text: ex.name!,
            color: controller.selectedIndex == ex.index
                ? colorScheme.primary
                : colorScheme.onPrimary,
            onPressed: () => controller.selectExercise(ex.index!),
          )).toList(),
        );
      },
    );
  }
}

class ExerciseDescriptionView extends StatelessWidget {
  const ExerciseDescriptionView({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PText('운동 설명', style: textTheme.bodyLarge),
        const SizedBox(height: 10.0),
        PText(exercise.description!, maxLines: 4),
      ],
    );
  }
}

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseDetailSetting>(
      builder: (controller) {
        final exercisePresenter = Get.find<ExercisePresenter>();
        Exercise exercise = exercisePresenter.exercises[controller.selectedIndex];
        return Card(
          color: colorScheme.background,
          child: Column(
            children: [
              ExerciseImageWidget(exercise: exercise),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const ExerciseSelectionButtonView(),
                          const SizedBox(height: 8.0),
                          ExerciseDescriptionView(exercise: exercise),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// 운동 상세 설정 뷰
class ExerciseDetailSettingView extends StatelessWidget {
  const ExerciseDetailSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseDetailSetting>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const ExerciseCard(),
              const SizedBox(height: 20.0),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PButton(
                    onPressed: Get.back,
                    constraints: const BoxConstraints(minWidth: 150.0),
                    text: '돌아가기',
                  ),
                  PButton(
                    onPressed: () => ExerciseMain.toExerciseMain(ExerciseState.stop),
                    constraints: const BoxConstraints(minWidth: 150.0),
                    text: '운동하기',
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
            ],
          ),
        );
      }
    );
  }
}
//
// class ExercisePage extends StatelessWidget {
//   const ExercisePage(
//       {Key? key,
//         required this.title,
//         required this.exercises,
//         required this.extraWeight,
//         this.challenge})
//       : super(key: key);
//   final String title;
//   final List exercises;
//   final bool extraWeight;
//   final String? challenge;
//
//   List<Widget> exerciseButton() {
//     return exercises
//         .map(
//           (exercise) => ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           primary: const Color(0xffd9d9d9),
//           fixedSize: const Size(80, 80),
//           shape: const CircleBorder(),
//         ),
//         child: Text(
//           exercise,
//           style: const TextStyle(color: Colors.black),
//         ),
//       ),
//     )
//         .toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
//       child: Card(
//         color: const Color(0xffFBF8F1),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(fontSize: 28.0),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 8.0),
//                         child: Text('운동 종류'),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: exerciseButton(),
//                     ),
//                     const SizedBox(
//                       height: 8.0,
//                     ),
//                     extraWeight
//                         ? Column(
//                       children: const [
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(vertical: 8.0),
//                             child: Text('추가 무게'),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: SizedBox(
//                             width: 200.0,
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 hintText: 'KG',
//                                 isDense: true,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 8.0),
//                       ],
//                     )
//                         : Container(),
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 8.0),
//                         child: Text('진행 중인 챌린지'),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Image.network(
//                           width: 100.0,
//                           'https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/4799/sperm-whale-clipart-md.png',
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   challenge!,
//                                   style: const TextStyle(fontSize: 16.0),
//                                 ),
//                                 const SizedBox(height: 4.0),
//                                 Container(
//                                   padding: const EdgeInsets.all(1.0),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .outline),
//                                     borderRadius: BorderRadius.circular(100.0),
//                                   ),
//                                   child: LinearPercentIndicator(
//                                     padding: EdgeInsets.zero,
//                                     lineHeight: 10,
//                                     barRadius: const Radius.circular(10.0),
//                                     percent: 0.7,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   child: const Text(
//                     '선택',
//                     style: TextStyle(fontSize: 28.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
