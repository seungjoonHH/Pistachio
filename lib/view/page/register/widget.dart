import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/number.dart';
import 'package:pistachio/global/string.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/level.dart';
import 'package:pistachio/presenter/page/register.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/card.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:text_scroll/text_scroll.dart';

// 회원가입 페이지 위젯 모음

// Carousel 뷰 위젯
class CarouselView extends StatelessWidget {
  const CarouselView({Key? key}) : super(key: key);

  // 회원가입 페이지 carousel 리스트
  static List<Widget> carouselWidgets() => const [
    UserInfoView(),
    WeightHeightView(),
    DistanceRecommendView(),
    DistanceGoalView(),
    HeightRecommendView(),
    HeightGoalView(),
    CalorieCheckView(),
    RecommendView(),
    CalorieExplanationView(),
    // WeightGoalView(),
  ];

  static int widgetCount = carouselWidgets().length;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    String asset = 'assets/image/page/register/';

    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return Stack(
          children: [
            for (int i = 0; i < controller.imageExistence.length; i++)
              AnimatedPositioned(
                left: screenSize.width * (i - controller.pageIndex),
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                width: screenSize.width,
                height: screenSize.height,
                child: controller.imageExistence[i] ? SvgPicture.asset(
                  '${asset}carousel_${i.toString().padLeft(2, '0')}.svg',
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                ) : Container(),
              ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 60.0),
                    alignment: Alignment.topCenter,
                    child: Container(
                      constraints: BoxConstraints(minWidth: screenSize.width),
                      child: CarouselSlider(
                        carouselController: RegisterPresenter.carouselCont,
                        items: carouselWidgets().map((widget) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: widget,
                        )).toList(),
                        options: CarouselOptions(
                          height: double.infinity,
                          initialPage: 0,
                          reverse: false,
                          enableInfiniteScroll: false,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                          viewportFraction: 1.0,
                          // onPageChanged: controller.pageChanged,
                        ),
                      ),
                    ),
                  ),
                ),
                const CarouselButton(),
              ],
            ),
          ],
        );
      },
    );
  }
}

// 닉네임 입력 뷰
class UserInfoView extends StatelessWidget {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: PText(
                  '보다 나은 서비스를 위해\n정보를 입력해주세요!',
                  style: textTheme.headlineSmall,
                  color: PTheme.black,
                  maxLines: 2,
                  align: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PText('별명',
                    style: textTheme.headlineSmall,
                    color: PTheme.black,
                  ),
                  const SizedBox(height: 8.0),
                  PInputField(
                    invalid: controller.fields['nickname']!.invalid,
                    controller: controller.fields['nickname']!.controller,
                    hintText: controller.fields['nickname']?.hintText ?? '별명을 입력해주세요',
                    hintColor: controller.fields['nickname']?.hintText == null ? PTheme.grey : PTheme.colorB,
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PText('생년월일',
                    style: textTheme.headlineSmall,
                    color: PTheme.black,
                  ),
                  const SizedBox(height: 8.0),
                  PInputField(
                    invalid: controller.fields['dateOfBirth']!.invalid,
                    controller: controller.fields['dateOfBirth']!.controller,
                    hintText: controller.fields['dateOfBirth']?.hintText ?? 'YYYYMMDD',
                    hintColor: controller.fields['dateOfBirth']?.hintText == null ? PTheme.grey : PTheme.colorB,
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PText('성별',
                    style: textTheme.headlineSmall,
                    color: PTheme.black,
                  ),
                  const SizedBox(height: 8.0),
                  ShakeWidget(
                    autoPlay: controller.fields['sex']!.invalid,
                    shakeConstant: ShakeHorizontalConstant2(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        SexSelectionButton(sex: Sex.male),
                        SizedBox(width: 20.0),
                        SexSelectionButton(sex: Sex.female),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// 성별 선택 버튼
class SexSelectionButton extends StatelessWidget {
  const SexSelectionButton({Key? key, required this.sex}) : super(key: key);

  final Sex sex;

  @override
  Widget build(BuildContext context) {
    const Map<Sex, String> texts = {
      Sex.male: '남자',
      Sex.female: '여자',
    };

    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return PButton(
          stretch: true,
          multiple: true,
          text: texts[sex],
          onPressed: () => controller.setSex(sex),
          backgroundColor: sex == controller.newcomer.sex ? PTheme.black: PTheme.white,
          textColor: sex == controller.newcomer.sex ? PTheme.white: PTheme.black,
        );
      },
    );
  }
}

// 체중 신장 선택 뷰
class WeightHeightView extends StatelessWidget {
  const WeightHeightView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> contents = {
      '체중': Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<RegisterPresenter>(
            builder: (controller) {
              return NumberPicker(
                onChanged: controller.setWeight,
                value: controller.newcomer.weight ?? 60,
                minValue: 30,
                maxValue: 220,
                selectedTextStyle: textTheme.headlineSmall,
                itemHeight: 30.0,
              );
            },
          ),
          const Text('kg'),
        ],
      ),
      '신장': Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<RegisterPresenter>(
            builder: (controller) {
              return NumberPicker(
                onChanged: controller.setHeight,
                value: controller.newcomer.height ?? 170,
                minValue: 100,
                maxValue: 220,
                selectedTextStyle: textTheme.headlineSmall,
                itemHeight: 30.0,
              );
            },
          ),
          const Text('cm'),
        ],
      ),
    };

    return Column(
      children: [
        Center(
          child: PText(
            '보다 나은 서비스를 위해\n정보를 입력해주세요!',
            style: textTheme.headlineSmall,
            color: PTheme.black,
            maxLines: 2,
            align: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: contents.entries.map((content) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText(content.key,
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 10.0),
                PCard(
                  rounded: true,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      content.value,
                    ],
                  ),
                ),
              ],
            )).toList(),
          ),
        ),
        Expanded(
          child: Center(
            child: PText(
              '*체중과 신장은 간편한 계산을 위해서만 사용될 뿐\n다른 곳에는 이용되지 않아요!',
              style: textTheme.bodyMedium,
              color: colorScheme.outline,
              maxLines: 2,
              align: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class GoalNumberPicker extends StatefulWidget {
  const GoalNumberPicker({
    Key? key,
    required this.type,
    this.style,
    this.itemCount = 1,
    this.itemWidth = 100.0,
    this.itemHeight = 120.0,
    this.minValue = 0,
    this.maxValue = 200,
    this.color = PTheme.black,
  }) : super(key: key);

  final ActivityType type;
  final TextStyle? style;
  final int itemCount;
  final double itemWidth;
  final double itemHeight;
  final int minValue;
  final int maxValue;
  final Color color;

  @override
  State<GoalNumberPicker> createState() => _GoalNumberPickerState();
}

class _GoalNumberPickerState extends State<GoalNumberPicker> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        int value = widget.type == ActivityType.distance
            ? controller.distanceMinute
            : (controller.newcomer.goals[widget.type.name] ?? 0);

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_drop_up,
                size: 40.0,
                color: value > widget.minValue
                    ? PTheme.black
                    : Colors.transparent,
              ),
              onPressed: () {
                controller.setGoal(widget.type, max(value - 1, widget.minValue));
                setState(() {});
              },
            ),
            NumberPicker(
              onChanged: (val) {
                controller.setGoal(widget.type, val);
                controller.update();
              },
              itemCount: widget.itemCount,
              itemWidth: widget.itemWidth,
              itemHeight: widget.itemHeight,
              value: value,
              minValue: widget.minValue,
              maxValue: widget.maxValue,
              textStyle: widget.style?.apply(color: PTheme.grey),
              selectedTextStyle: widget.style?.apply(color: widget.color),
            ),
            IconButton(
              icon: Icon(Icons.arrow_drop_down,
                size: 40.0,
                color: value < widget.maxValue
                    ? PTheme.black
                    : Colors.transparent,
              ),
              onPressed: () {
                controller.setGoal(widget.type, min(value + 1, widget.maxValue));
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}


class WeightGoalView extends StatelessWidget {
  const WeightGoalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 70.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PTexts(
                    [controller.fields['nickname']!.controller.text, '님의'],
                    colors: [ActivityType.calorie.color, PTheme.black],
                    style: textTheme.displaySmall,
                    alignment: MainAxisAlignment.start,
                  ),
                  Row(
                    children: [
                      PTexts(
                        const ['몸무게', '로 하루'],
                        colors: [ActivityType.calorie.color, PTheme.black],
                        style: textTheme.displaySmall,
                        alignment: MainAxisAlignment.start,
                        space: false,
                      ),
                      GoalNumberPicker(
                        type: ActivityType.weight,
                        style: textTheme.displaySmall,
                        color: PTheme.colorB,
                      ),
                      PText('회', style: textTheme.displaySmall),
                    ],
                  ),
                  PText('스쿼트하면', style: textTheme.displaySmall),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 200.0.w,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: PText('${LevelPresenter.getTier(
                                ActivityType.weight, controller.weightPerDay,
                              )['currentTitle']}',
                                style: textTheme.displaySmall,
                                color: PTheme.colorC,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10.0),
                      PText('(${LevelPresenter.getTier(
                        ActivityType.weight, controller.weightPerDay,
                      )['currentValue']}${ActivityType.weight.unitAlt})',
                        style: textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  PText('${eulReul(LevelPresenter.getTier(
                    ActivityType.weight, controller.weightPerDay,
                  )['currentTitle'])} 들 수 있어요!',
                    style: textTheme.headlineSmall,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class DistanceRecommendView extends StatelessWidget {
  const DistanceRecommendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        int ageGroup = today.difference(controller.newcomer.dateOfBirth!).inDays;
        List<int> recommendTimes = [];
        ageGroup = (ageGroup / 3650).floor() * 10;

        ageGroup < 60 && controller.newcomer.sex == Sex.male;

        if (ageGroup < 20) { recommendTimes = [60]; }
        else if (ageGroup < 60) { recommendTimes = [20, 40]; }
        else { recommendTimes = [30, 50]; }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PTexts(
              ['$ageGroup', '대 ', controller.newcomer.sex!.kr, ' 평균'],
              colors: const [PTheme.colorA, PTheme.black, PTheme.colorA, PTheme.black],
              alignment: MainAxisAlignment.start,
              space: false,
              style: textTheme.displaySmall,
            ),
            PTexts(['매일', '${recommendTimes.length == 1
                ? recommendTimes[0]
                : recommendTimes.join('~')}', '분',
            ], colors: [PTheme.black, ActivityType.distance.color, PTheme.black],
              alignment: MainAxisAlignment.start,
              style: textTheme.displaySmall,
            ),
            PText('유산소 운동이\n적당해요',
              style: textTheme.displaySmall,
              maxLines: 2,
            ),
          ],
        );
      },
    );
  }
}

class DistanceGoalView extends StatelessWidget {
  const DistanceGoalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: GoalNumberPicker(
                type: ActivityType.distance,
                itemWidth: 200.0,
                color: PTheme.colorB,
                style: PTheme.largeText,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PTexts(['하루 ', controller.distanceMinute.toString(), '분이면'],
                  colors: const [PTheme.black, PTheme.colorA, PTheme.black],
                  style: textTheme.displaySmall,
                  alignment: MainAxisAlignment.end,
                  space: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 230.0.w),
                      child: TextScroll(LevelPresenter.getTier(
                        ActivityType.distance, convertDistance(
                        controller.distanceMinute,
                        DistanceUnit.minute,
                        DistanceUnit.kilometer,
                      ))['currentTitle'],
                        style: textTheme.displaySmall?.merge(TextStyle(
                          color: ActivityType.distance.color,
                          fontWeight: FontWeight.normal,
                        )),
                        velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                        intervalSpaces: 5,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    PText('(${unitDistance(convertDistance(LevelPresenter.getTier(
                      ActivityType.distance, convertDistance(
                      controller.distanceMinute,
                      DistanceUnit.minute,
                      DistanceUnit.kilometer,
                    ))['currentValue'], DistanceUnit.kilometer, DistanceUnit.step))})'),
                  ],
                ),
                PText('${eulReul(LevelPresenter.getTier(
                  ActivityType.distance, controller.weightPerDay,
                )['currentTitle'])} 정복할 수 있어요',
                  style: textTheme.displaySmall,
                ),
                PText('* 약 ${toLocalString(
                    controller.newcomer.goals[ActivityType.distance.name],
                )}보',
                  color: PTheme.colorB,
                ),
              ],
            ),
            const SizedBox(height: 100.0),
          ],
        );
      },
    );
  }
}

class HeightRecommendView extends StatelessWidget {
  const HeightRecommendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PText('한 층을', style: textTheme.displaySmall, color: PTheme.colorA),
        PText('오를 때마다', style: textTheme.displaySmall),
        PText('건강 수명이', style: textTheme.displaySmall),
        PTexts(
          const ['1분 20초', '연장돼요'],
          colors: [ActivityType.height.color, PTheme.black],
          style: textTheme.displaySmall,
          alignment: MainAxisAlignment.start,
        ),
      ],
    );
  }
}

class HeightGoalView extends StatelessWidget {
  const HeightGoalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText('하루', style: textTheme.displaySmall),
                PTexts(['${controller.newcomer.goals[ActivityType.height.name]}', '층이면'],
                  colors: [ActivityType.calorie.color, PTheme.black],
                  alignment: MainAxisAlignment.start,
                  style: textTheme.displaySmall,
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 210.0.w),
                  child: TextScroll(LevelPresenter.getTier(
                    ActivityType.height,
                    controller.newcomer.goals[ActivityType.height.name],
                  )['currentTitle'],
                    style: textTheme.displaySmall?.merge(const TextStyle(
                      color: PTheme.colorD,
                      fontWeight: FontWeight.normal,
                    )),
                    velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                    intervalSpaces: 5,
                  ),
                ),
                PText('(${LevelPresenter.getTier(
                  ActivityType.height, controller.newcomer.goals[ActivityType.height.name],
                )['currentValue']}층)'),
                PText('정복', style: textTheme.displaySmall),
              ],
            ),
            const Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.topRight,
              child: GoalNumberPicker(
                type: ActivityType.height,
                itemWidth: 200.0,
                color: PTheme.colorD,
                style: PTheme.largeText,
              ),
            ),
            const SizedBox(height: 100.0),
          ],
        );
      },
    );
  }
}

// Carousel 인디케이터 위젯
class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    Key? key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return SizedBox(
          height: 45.0,
          child: DotsIndicator(
            dotsCount: count,
            position: controller.pageIndex.toDouble(),
            decorator: DotsDecorator(
              color: Theme.of(context).colorScheme.primaryContainer,
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}

class CalorieCheckView extends StatelessWidget {
  const CalorieCheckView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText('하루에', style: textTheme.headlineMedium),
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 200.0),
                      child: TextScroll(LevelPresenter.getTier(
                        ActivityType.distance, convertDistance(
                          controller.distanceMinute,
                          DistanceUnit.minute,
                          DistanceUnit.kilometer,
                        ))['currentTitle'],
                        style: textTheme.headlineMedium?.merge(TextStyle(
                          color: ActivityType.distance.color,
                          fontWeight: FontWeight.normal,
                        )),
                        velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                        intervalSpaces: 5,
                      ),
                    ),
                    const SizedBox(width: 7.0),
                    PText('만큼 걷고',
                      style: textTheme.headlineMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextScroll(LevelPresenter.getTier(
                      ActivityType.height, controller.newcomer.goals[ActivityType.height.name])['currentTitle'],
                      style: textTheme.headlineMedium?.merge(TextStyle(
                        color: ActivityType.height.color,
                        fontWeight: FontWeight.normal,
                      )),
                      velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                      intervalSpaces: 5,
                    ),
                    const SizedBox(width: 7.0),
                    PText('만큼 오르면...',
                      style: textTheme.headlineMedium,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 300.0.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PTexts(['총', '${controller.newcomer.goals[ActivityType.calorie.name]} kcal', '를'],
                  colors: [PTheme.black, ActivityType.calorie.color, PTheme.black],
                  style: textTheme.displaySmall,
                  alignment: MainAxisAlignment.end,
                ),
                PText('소모 할 수 있어요',
                  color: PTheme.black,
                  style: textTheme.displaySmall,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class RecommendView extends StatelessWidget {
  const RecommendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            '건강을 위해',
            style: TextStyle(fontSize: 36),
          ),
          Text(
            '음식을 참아보는 건',
            style: TextStyle(fontSize: 36),
          ),
          Text(
            '어떨까요?',
            style: TextStyle(fontSize: 36),
          ),
          SizedBox(height: 120.0),
        ],
      ),
    );
  }
}

class CalorieExplanationView extends StatelessWidget {
  const CalorieExplanationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  '오늘 ',
                  style: TextStyle(fontSize: 36),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 2000),
                  child: Text(
                    controller.example['name']!,
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
              ],
            ),
            const Text(
              '먹는 걸 참으면',
              style: TextStyle(fontSize: 36),
            ),
            Row(
              children: [
                const Text(
                  '추가로 ',
                  style: TextStyle(fontSize: 36),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    controller.example['kcal']!,
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
              ],
            ),
            const Text(
              '감량할 수 있어요',
              style: TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 30.0),
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Image.network(
                  controller.example['image']!,
                  width: 300.0,
                  height: 300.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Carousel 버튼
class CarouselButton extends StatelessWidget {
  const CarouselButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        bool lastPage = controller.pageIndex == CarouselView.widgetCount - 1;

        return Row(
          children: [
            PButton(
              onPressed: controller.backPressed,
              text: '이전',
              textColor: Colors.black,
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15.0),
              stretch: true,
              multiple: true,
            ),
            PButton(
              onPressed: () async {
                if (controller.keyboardVisible) {
                  FocusScope.of(context).unfocus();
                  await Future.delayed(const Duration(milliseconds: 100));
                }
                controller.nextPressed();
              },
              text: lastPage ? '완료' : '다음',
              backgroundColor: Colors.black,
              padding: const EdgeInsets.all(15.0),
              stretch: true,
              multiple: true,
            ),
          ],
        );
      },
    );
  }
}
