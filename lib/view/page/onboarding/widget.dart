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

class CarouselView extends StatelessWidget {
  const CarouselView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> messages = [
      '일상 운동 기록,\n어떻게 관리하시나요?',
      '입력만 하세요!\n피스타치오가 의미있게\n만들어드릴게요',
      '무게, 유산소, 계단 오르기에\n칼로리까지 기록 가능해요!',
      '오늘의 목표 설정을 통해\n더 쉽게 관리 해보세요!',
    ];

    return GetBuilder<OnboardingPresenter>(
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 50.0),
                alignment: Alignment.topCenter,
                child: CarouselSlider(
                  carouselController: OnboardingPresenter.carouselCont,
                  items: List.generate(messages.length, (index) => Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 50.0,
                        child: PText(messages[index],
                          maxLines: 3,
                          style: textTheme.headlineSmall,
                          align: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: SvgPicture.asset(
                          OnboardingPresenter.getAsset(index),
                        ),
                      ),
                    ],
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
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 50.0,
              child: controller.visible
                  ? const PButton(
                onPressed: RegisterPresenter.toRegister,
                text: '설정하러 가기',
                stretch: true,
              ) : CarouselIndicator(count: messages.length),
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