import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/page/exercise/input.dart';
import 'package:pistachio/view/page/exercise/input/widget.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class ExerciseInputPage extends StatelessWidget {
  const ExerciseInputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActivityType type = Get.arguments;

    Map<ActivityType, String> messages = {
      ActivityType.distance: '유산소 운동을 한 시간을 입력해요.',
      ActivityType.height: '오른 층 수를 입력해요.',
      ActivityType.weight: '운동한 횟수를 입력해요.',
      ActivityType.calorie: '참은 음식을 선택해주세요.',
    };

    Map<ActivityType, String> hints = {
      ActivityType.distance: '분 입력',
      ActivityType.height: '층 수 입력',
      ActivityType.weight: '회 입력',
      ActivityType.calorie: '',
    };

    Map<ActivityType, String> riveName = {
      ActivityType.distance: 'assets/rive/input/jogger.riv',
      ActivityType.height: 'assets/rive/input/2967-6217-dog-psych.riv',
      ActivityType.weight: 'assets/rive/input/lumberjack_squats.riv',
      ActivityType.calorie: 'assets/rive/input/2967-6217-dog-psych.riv',
    };

    Map<ActivityType, String> riveArtboard = {
      ActivityType.distance: 'Joggers',
      ActivityType.height: 'Shiba_inu',
      ActivityType.weight: 'Squat',
      ActivityType.calorie: 'Shiba_inu',
    };

    Map<ActivityType, String> riveAnimations = {
      ActivityType.distance: 'Stand',
      ActivityType.height: 'Shiba_inu',
      ActivityType.weight: 'Squat',
      ActivityType.calorie: 'Shiba_inu',
    };


    return Scaffold(
      appBar: const PAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PText(
                  '오늘 ${messages[type]!}\n피스타치오가 알아서 계산해 줄게요.',
                  style: textTheme.bodyLarge,
                  maxLines: 2,
                ),
                TextField(
                  controller: ExerciseInput.inputCont,
                  decoration: InputDecoration(
                    hintText: hints[type]!,
                  ),
                ),
              ],
            ),
            RAnimation(
              rname: riveName[type]!,
              abname: riveArtboard[type]!,
              aname: riveAnimations[type]!,),

            GetBuilder<ExerciseInput>(
              builder: (controller) {
                return PButton(
                  onPressed: () => controller.completeButtonPressed(type),
                  text: '입력 완료',
                  stretch: true,
                  backgroundColor: PTheme.colorD,
                  textColor: PTheme.black,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
