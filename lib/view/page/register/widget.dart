import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../model/enum/enum.dart';
import '../../../presenter/model/user.dart';
import '../../../presenter/page/register.dart';

// 회원가입 페이지 위젯 모음
// Carousel 뷰 위젯
class CarouselView extends StatelessWidget {
  const CarouselView({Key? key}) : super(key: key);

  // 회원가입 페이지 carousel 리스트
  static List<Widget> carouselWidgets() => const [
        UserInfoView(),
        WeightHeightView(),
      ];
  static int widgetCount = carouselWidgets().length;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool keyboardDisabled =
        WidgetsBinding.instance.window.viewInsets.bottom < 100.0;

    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 50.0),
            alignment: Alignment.topCenter,
            child: Container(
              constraints: BoxConstraints(minWidth: screenSize.width),
              child: CarouselSlider(
                carouselController: RegisterPresenter.carouselCont,
                items: carouselWidgets()
                    .map((widget) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: widget,
                        ))
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
        Container(
          height: keyboardDisabled ? 200.0 : 100.0,
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Carousel 인디케이터
              CarouselIndicator(count: widgetCount),
              // Carousel 다음 버튼
              const CarouselNextButton(),
            ],
          ),
        ),
      ],
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
        return Column(
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
    final registerCont = Get.find<RegisterPresenter>();

    const Map<Sex, String> texts = {
      Sex.male: '남자',
      Sex.female: '여자',
    };

    return GetBuilder<UserPresenter>(builder: (userCont) {
      return SizedBox(
        width: 128.0,
        height: 40.0,
        child: ElevatedButton(
          onPressed: () => registerCont.setSex(sex),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0.0,
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Text(texts[sex]!),
        ),
      );
      //   FWButton(
      //   text: texts[sex],
      //   width: 128.0,
      //   fill: sex == userCont.user.sex,
      //   onPressed: () => registerCont.sexSelected(sex),
      // );
    });
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
                itemCount: 5,
                onChanged: (value) => controller.weightChanged(value),
                value: controller.weight!,
                minValue: 30,
                maxValue: 220,
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
                itemCount: 5,
                onChanged: (value) => controller.heightChanged(value),
                value: controller.height!,
                minValue: 100,
                maxValue: 220,
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
      //     FWCard(
      //   title: contents.keys.toList()[index],
      //   child: contents[contents.keys.toList()[index]]!,
      // ),
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
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
          height: 100.0,
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

// Carousel 다음 버튼
class CarouselNextButton extends StatelessWidget {
  const CarouselNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(builder: (controller) {
      bool lastPage = controller.pageIndex == CarouselView.widgetCount - 1;

      return SizedBox(
        width: 120.0,
        height: 45.0,
        child: ElevatedButton(
          onPressed: () {
            controller.nextPressed();
            FocusScope.of(context).unfocus();
          },
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0.0,
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: lastPage ? const Text('완료') : const Text('다음'),
        ),
      );
      //   FWButton(
      //   onPressed: () {
      //     controller.nextPressed();
      //     FocusScope.of(context).unfocus();
      //   },
      //   width: 120.0,
      //   height: 45.0,
      //   text: lastPage ? '완료' : '다음',
      // );
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:pistachio/model/enum/enum.dart';
// import 'package:pistachio/presenter/page/register.dart';
//
// class Register extends StatelessWidget {
//   const Register({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<RegisterPresenter>(
//       builder: (controller) {
//         return SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Nickname',
//                       style: TextStyle(fontSize: 20.0),
//                     ),
//                     const SizedBox(height: 8.0),
//                     SizedBox(
//                       width: double.infinity,
//                       child: TextFormField(
//                         controller: RegisterPresenter.nickNameCont,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Nickname',
//                           isDense: true,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(thickness: 1.0),
//               const Padding(
//                 padding:
//                 EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                 child: Text(
//                   'Sex',
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//               ),
//               Column(
//                 children: Sex.values.map((method) {
//                   return ListTile(
//                     title: Text(method.kr),
//                     leading: Radio<Sex>(
//                       value: method,
//                       groupValue: controller.sex,
//                       onChanged: controller.setSex,
//                     ),
//                   );
//                 }).toList(),
//               ),
//               const Divider(thickness: 1.0),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Height',
//                       style: TextStyle(fontSize: 20.0),
//                     ),
//                     const SizedBox(height: 8.0),
//                     SizedBox(
//                       width: double.infinity,
//                       child: TextFormField(
//                         controller: RegisterPresenter.heightCont,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'height',
//                           isDense: true,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(thickness: 1.0),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Weight',
//                       style: TextStyle(fontSize: 20.0),
//                     ),
//                     const SizedBox(height: 8.0),
//                     SizedBox(
//                       width: double.infinity,
//                       child: TextFormField(
//                         controller: RegisterPresenter.weightCont,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'weight',
//                           isDense: true,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(thickness: 1.0),
//               Padding(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Birthday',
//                       style: TextStyle(fontSize: 20.0),
//                     ),
//                     const SizedBox(height: 8.0),
//                     SizedBox(
//                       width: double.infinity,
//                       child: TextFormField(
//                         controller: RegisterPresenter.birthdayCont,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Ex) 19990828',
//                           isDense: true,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Center(
//                 child: OutlinedButton(
//                   onPressed: controller.submitted,
//                   child: const Text('추가하기'),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
