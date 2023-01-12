import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/activity_type.dart';
import 'package:pistachio/presenter/page/exercise/input.dart';
import 'package:pistachio/view/page/exercise/input/widget.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class ExerciseInputPage extends StatelessWidget {
  const ExerciseInputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.arguments == null) return const Scaffold();
    ActivityType type = Get.arguments;

    Map<ActivityType, List<String>> messages = {
      ActivityType.calorie: ['오늘 ', '참은 음식', '을 선택해주세요.'],
      ActivityType.distance: ['오늘 한 ', '유산소 운동 시간', '을 입력해주세요.'],
      ActivityType.height: ['오늘 ', '오른 층 수', '를 입력해주세요.'],
      ActivityType.weight: ['오늘 ', '운동한 횟수', '를 입력해주세요.'],
    };

    Map<ActivityType, String> hints = {
      ActivityType.calorie: '',
      ActivityType.distance: '분 입력',
      ActivityType.height: '층 수 입력',
      ActivityType.weight: '회 입력',
    };

    Map<ActivityType, String> riveAssets = {
      ActivityType.calorie: 'assets/rive/input/537-1015-sport-charts.riv',
      ActivityType.distance: 'assets/rive/input/jogger.riv',
      ActivityType.height:
          'assets/rive/input/1738-3431-raster-graphics-example.riv',
      ActivityType.weight: 'assets/rive/input/lumberjack_squats.riv',
    };

    Map<ActivityType, String> riveArtboard = {
      ActivityType.calorie: 'New Artboard',
      ActivityType.distance: 'Joggers',
      ActivityType.height: 'New Artboard',
      ActivityType.weight: 'Squat',
    };

    Map<ActivityType, String> riveAnimations = {
      ActivityType.calorie: 'Example',
      ActivityType.distance: 'Jog',
      ActivityType.height: 'Animation 1',
      ActivityType.weight: 'Demo',
    };

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: PAppBar(title: '${type.kr} 입력'),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PTexts(messages[type]!,
                    alignment: MainAxisAlignment.start,
                    colors: [PTheme.black, type.color, PTheme.black],
                    style: textTheme.bodyLarge,
                    space: false,
                  ),
                  PText('피스타치오가 알아서 계산해 줄게요.',
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20.0),
                  GetBuilder<ExerciseInput>(
                    builder: (controller) {
                      return PInputField(
                        controller: controller.inputCont,
                        hintText: controller.hintText ?? hints[type]!,
                        keyboardType: TextInputType.number,
                        invalid: controller.invalid,
                        hintColor: controller.hintText == null
                            ? PTheme.grey : PTheme.colorB,
                      );
                    }
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RAnimation(
                    rName: riveAssets[type]!,
                    abName: riveArtboard[type]!,
                    aName: riveAnimations[type]!,
                  ),
                ),
              ),
              GetBuilder<ExerciseInput>(
                builder: (controller) {
                  return PButton(
                    onPressed: () => controller.completeButtonPressed(type),
                    text: '입력 완료',
                    stretch: true,
                    backgroundColor: type.color,
                    textColor: PTheme.black,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
