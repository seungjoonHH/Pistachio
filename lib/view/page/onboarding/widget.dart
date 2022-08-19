import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pistachio/presenter/page/onboarding.dart';
//
// class CarouselView extends StatelessWidget {
//   const CarouselView({Key? key}) : super(key: key);
//
//   // 회원가입 페이지 carousel 리스트
//   static List<Widget> carouselWidgets() => const [
//     UserInfoView(),
//     WeightHeightView(),
//     RoleView(),
//   ];
//   static int widgetCount = carouselWidgets().length;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Container(
//             padding: const EdgeInsets.only(top: 50.0),
//             alignment: Alignment.topCenter,
//             child: Container(
//               child: CarouselSlider(
//                 carouselController: OnboardingPresenter.carouselCont,
//                 items: carouselWidgets().map((widget) => Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                   child: widget,
//                 )).toList(),
//                 options: CarouselOptions(
//                   height: double.infinity,
//                   initialPage: 0,
//                   reverse: false,
//                   enableInfiniteScroll: false,
//                   scrollPhysics: const NeverScrollableScrollPhysics(),
//                   viewportFraction: 1.0,
//                   // onPageChanged: controller.pageChanged,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 45.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Carousel 인디케이터
//               CarouselIndicator(count: widgetCount),
//               // Carousel 다음 버튼
//               const CarouselNextButton(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
// // Carousel 인디케이터 위젯
// class CarouselIndicator extends StatelessWidget {
//   const CarouselIndicator({
//     Key? key,
//     required this.count,
//   }) : super(key: key);
//
//   final int count;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100.0,
//       child: DotsIndicator(
//         dotsCount: count,
//         // position: controller.pageIndex.toDouble(),
//         decorator: DotsDecorator(
//           color: Theme.of(context).colorScheme.primaryContainer,
//           activeColor: Theme.of(context).colorScheme.primary,
//         ),
//       ),
//     );
//   }
// }