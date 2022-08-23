import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/page/register.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/text.dart';

// 회원가입 페이지 위젯 모음

// Carousel 뷰 위젯
class CarouselView extends StatelessWidget {
  const CarouselView({Key? key}) : super(key: key);

  // 회원가입 페이지 carousel 리스트
  static List<Widget> carouselWidgets() => const [
        UserInfoView(),
        WeightHeightView(),
        WeightGoalView(),
        DistanceRecommendView(),
        DistanceGoalView(),
        HeightRecommendView(),
        HeightGoalView(),
        CalorieCheckView(),
        RecommendView(),
        CalorieExplanationView(),
      ];

  static int widgetCount = carouselWidgets().length;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Map image = {
      3: 'distanceRecommend.svg',
      4: 'distanceGoal.svg',
      5: 'heightRecommend.svg',
      6: 'heightGoal.svg',
    };

    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return Stack(
          children: [
            controller.pageIndex > 2 && controller.pageIndex < 7
                ? SvgPicture.asset(
                    'assets/image/page/register/${image[controller.pageIndex]}',
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  )
                : Container(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 60.0),
                    alignment: Alignment.topCenter,
                    child: Container(
                      constraints: BoxConstraints(minWidth: screenSize.width),
                      child: CarouselSlider(
                        carouselController: RegisterPresenter.carouselCont,
                        items: carouselWidgets()
                            .map(
                              (widget) => Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30.0),
                                child: widget,
                              ),
                            )
                            .toList(),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('닉네임을 입력하세요.'),
                  const SizedBox(height: 8.0),
                  ShakeWidget(
                    autoPlay: controller.invalids[0],
                    shakeConstant: ShakeHorizontalConstant2(),
                    child: TextFormField(
                      controller: RegisterPresenter.nickNameCont,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '별명',
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text('한글, 영문, 숫자만 입력해주세요.'),
                ],
              ),
              Divider(
                height: 40.0,
                thickness: 2.0,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('생년월일을 입력하세요.'),
                  const SizedBox(height: 8.0),
                  ShakeWidget(
                    autoPlay: controller.invalids[1],
                    shakeConstant: ShakeHorizontalConstant2(),
                    child: TextFormField(
                      controller: RegisterPresenter.birthdayCont,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'YYYYMMDD',
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 40.0,
                thickness: 2.0,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('성별을 선택하세요.'),
                  const SizedBox(height: 8.0),
                  ShakeWidget(
                    autoPlay: controller.invalids[2],
                    shakeConstant: ShakeHorizontalConstant2(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        SexSelectionButton(sex: Sex.male),
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
        return SizedBox(
          width: 128.0,
          height: 40.0,
          child: ElevatedButton(
            onPressed: () => controller.setSex(sex),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              elevation: 0.0,
              backgroundColor: sex == controller.newcomer.sex
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onPrimary,
              side: BorderSide(color: Theme.of(context).colorScheme.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Text(
              texts[sex]!,
              style: TextStyle(
                color: sex == controller.newcomer.sex
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
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
                itemCount: 3,
                value: controller.newcomer.weight ?? 60,
                minValue: 30,
                maxValue: 220,
                selectedTextStyle: Theme.of(context)
                    .textTheme.headline5
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
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
                selectedTextStyle: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              );
            },
          ),
          const Text('cm'),
        ],
      ),
    };

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: contents.length,
      itemBuilder: (context, index) => Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(contents.keys.toList()[index]),
              contents[contents.keys.toList()[index]]!,
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
    );
  }
}

class WeightGoalView extends StatelessWidget {
  const WeightGoalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFirst = true;
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      RegisterPresenter.nickNameCont.text,
                      style: TextStyle(
                        fontSize: 36,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const Text(
                      '님의',
                      style: TextStyle(
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '몸무게로 ',
                      style: TextStyle(fontSize: 36),
                    ),
                    GetBuilder<RegisterPresenter>(
                      builder: (controller) {
                        if (isFirst) {
                          Future.delayed(const Duration(
                            milliseconds: 500,
                          ), () => controller.setGoal(
                            ActivityType.weight, 10,
                          ));
                          isFirst = false;
                        }
                        return NumberPicker(
                          onChanged: (value) => controller.setGoal(ActivityType.weight, value),
                          itemCount: 1,
                          itemHeight: 48,
                          itemWidth: 80,
                          value: controller.newcomer.goals[ActivityType.weight.name] ?? 0,
                          minValue: 0,
                          maxValue: 200,
                          selectedTextStyle: TextStyle(
                            fontSize: 36.0,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
                    ),
                    const Text(
                      '회',
                      style: TextStyle(fontSize: 36),
                    ),
                  ],
                ),
                const Text(
                  '스쿼트하면',
                  style: TextStyle(fontSize: 36),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      '북극곰',
                      style: TextStyle(fontSize: 36),
                    ),
                    Text(
                      '(500kg)',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                const Text(
                  '을(를) 들 수 있어요!',
                  style: TextStyle(fontSize: 36),
                ),
              ],
            ),
          ],
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
        int ageGroup = DateTime.now()
            .difference(DateTime.utc(
              int.parse(RegisterPresenter.birthdayCont.text.substring(0, 4)),
              int.parse(RegisterPresenter.birthdayCont.text.substring(4, 6)),
              int.parse(RegisterPresenter.birthdayCont.text.substring(6)),
            ))
            .inDays;

        ageGroup = (ageGroup / 3650).floor();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${ageGroup}0',
                  style: const TextStyle(fontSize: 36),
                ),
                const Text('대 ',
                  style: TextStyle(fontSize: 36),
                ),
                Text(controller.newcomer.sex!.kr,
                  style: const TextStyle(fontSize: 36),
                ),
                const Text(' 평균',
                  style: TextStyle(fontSize: 36),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  '매일 ',
                  style: TextStyle(fontSize: 36),
                ),
                ageGroup < 6
                    ? controller.newcomer.sex == Sex.male
                        ? const Text('30 ~ 60',
                            style: TextStyle(fontSize: 36),
                          )
                        : const Text('10 ~ 30',
                            style: TextStyle(fontSize: 36),
                          )
                    : const Text('30 ~ 50',
                        style: TextStyle(fontSize: 36),
                      ),
                const Text('분',
                  style: TextStyle(fontSize: 36),
                ),
              ],
            ),
            const Text('유산소 운동이',
              style: TextStyle(fontSize: 36),
            ),
            const Text('적당해요',
              style: TextStyle(fontSize: 36),
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
    bool isFirst = true;
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        if (isFirst) {
          Future.delayed(const Duration(milliseconds: 500), () {
            controller.setGoal(ActivityType.distance, 15);
          });
          isFirst = false;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: NumberPicker(
                onChanged: (value) => controller.setGoal(ActivityType.distance, value),
                itemCount: 1,
                itemHeight: 132.0,
                itemWidth: 200.0,
                value: controller.distanceMinute,
                minValue: 0,
                maxValue: 200,
                selectedTextStyle: TextStyle(
                  fontSize: 120.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 200.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      '하루 ',
                      style: TextStyle(fontSize: 28),
                    ),
                    Text(
                      '${controller.distanceMinute}',
                      style: TextStyle(
                        fontSize: 28,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const Text(
                      '분이면',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "한강대교 왕복",
                      style: TextStyle(
                        fontSize: 28,
                        color: Color(0xffE45B47),
                        // Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      '이',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                const Text(
                  '가능해요!',
                  style: TextStyle(fontSize: 28),
                ),
                PText('* 약 ${controller.newcomer.goals[ActivityType.distance.name]} m',
                  color: PTheme.brickRed,
                ),
              ],
            ),
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
        Text(
          '한 층을',
          style: TextStyle(
            fontSize: 36,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Text(
          '오를 마다',
          style: TextStyle(fontSize: 36),
        ),
        const Text(
          '건강 수명이',
          style: TextStyle(fontSize: 36),
        ),
        Row(
          children: [
            Text(
              '1분 20초',
              style: TextStyle(
                fontSize: 36,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Text(
              ' 연장돼요',
              style: TextStyle(fontSize: 36),
            ),
          ],
        ),
      ],
    );
  }
}

class HeightGoalView extends StatelessWidget {
  const HeightGoalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFirst = true;
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        if (isFirst) {
          Future.delayed(const Duration(milliseconds: 500), () {
            controller.setGoal(ActivityType.height, 15);
          });
          isFirst = false;
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('하루 ',
                      style: TextStyle(fontSize: 28),
                    ),
                    Text('${controller.newcomer.goals[ActivityType.height.name] ?? 0}',
                      style: TextStyle(
                        fontSize: 28,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const Text(
                      '층이면',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "자유의 여신상",
                      style: TextStyle(
                        fontSize: 28,
                        color: Color(0xffE45B47),
                        // Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const Text(
                  '정복!',
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
            const SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: NumberPicker(
                  onChanged: (value) => controller.setGoal(ActivityType.height, value),
                  itemCount: 1,
                  itemHeight: 132.0,
                  itemWidth: 200.0,
                  value: controller.newcomer.goals[ActivityType.height.name] ?? 0,
                  minValue: 0,
                  maxValue: 200,
                  selectedTextStyle: TextStyle(
                    fontSize: 120.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
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
                const Text(
                  '하루에',
                  style: TextStyle(fontSize: 28),
                ),
                Row(
                  children: const [
                    Text(
                      '북극곰 한 마리',
                      style: TextStyle(fontSize: 28),
                    ),
                    Text(
                      '를 들고',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      '한강대교',
                      style: TextStyle(fontSize: 28),
                    ),
                    Text(
                      '를 달리고',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      '자유의 여신',
                      style: TextStyle(fontSize: 28),
                    ),
                    Text(
                      '을 정복하면',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 200.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      '총 ',
                      style: TextStyle(fontSize: 36),
                    ),
                    Text(
                      '${controller.newcomer.goals[ActivityType.calorie.name]} kcal',
                      style: TextStyle(
                        fontSize: 36,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const Text(
                      '를',
                      style: TextStyle(fontSize: 36),
                    ),
                  ],
                ),
                const Text(
                  '소모할 수 있어요',
                  style: TextStyle(fontSize: 36),
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
              stretch: true,
              multiple: true,
            ),
            PButton(
              onPressed: controller.nextPressed,
              text: lastPage ? '완료' : '다음',
              backgroundColor: Colors.black,
              stretch: true,
              multiple: true,
            ),
          ],
        );
      },
    );
  }
}
