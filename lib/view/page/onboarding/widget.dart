import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/page/onboarding.dart';
import 'package:pistachio/presenter/page/register.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class CarouselView extends StatefulWidget {
  const CarouselView({Key? key}) : super(key: key);

  @override
  State<CarouselView> createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> {
  late double opacity;

  @override
  void initState() {
    opacity = .0;
    Future.delayed(Duration.zero, () {
      setState(() => opacity = 1.0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> messages = [
      '일상 운동 기록,\n어떻게 관리하시나요?',
      '입력만 하세요!\n피스타치오가 의미있게\n만들어드릴게요',
      '유산소, 계단 오르기를\n 기록 가능해요!',
      '오늘의 목표 설정을 통해\n더 쉽게 관리 해보세요!',
      "피스타치오가 애플 건강 앱과 연동을 하여\n운동 데이터(걸음 수, 올라간 층수)를 수집합니다.\n피스타치오가 수집한 건강 및 피트니스 목적으로 사용되며 샤용자가 소모한 칼로리를 계산하고\n운동 데이터를 축적해 시각적으로 표현해줍니다!"
    ];

    return GetBuilder<OnboardingPresenter>(
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: CarouselSlider(
                carouselController: OnboardingPresenter.carouselCont,
                items: List.generate(messages.length, (index) => AnimatedOpacity(
                  duration: const Duration(milliseconds: 1000),
                  opacity: opacity,
                  curve: Curves.easeInOut,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PText(messages[index],
                        maxLines: 8,
                        style: textTheme.headlineSmall,
                        align: TextAlign.center,
                      ),
                      SvgPicture.asset(
                        OnboardingPresenter.getAsset(index),
                      ),
                    ],
                  ),
                )).toList(),
                options: CarouselOptions(
                  height: double.infinity,
                  initialPage: 0,
                  reverse: false,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                  onPageChanged: (index, _) => controller.pageChanged(index),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 50.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CarouselIndicator(count: messages.length),
                  if (controller.visible)
                  PButton(
                    onPressed: RegisterPresenter.toRegister,
                    text: '시작하기',
                    stretch: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50.0),
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
    return GetBuilder<OnboardingPresenter>(
      builder: (controller) {
        return DotsIndicator(
          dotsCount: count,
          position: controller.pageIndex.toDouble(),
          decorator: DotsDecorator(
            color: PTheme.grey,
            activeColor: PTheme.black,
            size: const Size(10.0, 10.0),
            activeSize: const Size(150.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        );
      },
    );
  }
}