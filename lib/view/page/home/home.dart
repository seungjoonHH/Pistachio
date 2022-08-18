import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/view/page/home/widget.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius radius = const BorderRadius.vertical(
      top: Radius.circular(30.0),
    );

    return Scaffold(
      appBar: const HomeAppBar(),
      bottomSheet: BottomSheetBar(
        locked: false,
        height: 80.0,
        controller: GlobalPresenter.barCont,
        borderRadiusExpanded: radius,
        boxShadows: [BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3.0,
            blurRadius: 10.0,
            offset: Offset.zero,
        )],
        isDismissable: false,
        color: colorScheme.surfaceVariant,
        expandedBuilder: (scrollCont) => ListView(
          controller: scrollCont,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    color: colorScheme.surfaceVariant,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  width: 100.0, height: 7.0,
                  decoration: BoxDecoration(
                    color: colorScheme.outline,
                    borderRadius: BorderRadius.circular(3.5),
                  ),
                ),
              ],
            ),
            Container(
              height: 170.0.h,
              color: PTheme.tertiary[70],
              child: Stack(
                children: [
                  Positioned(
                    left: 20.0, top: 20.0,
                    child: PText('무게 입력하기', style: textTheme.displaySmall),
                  ),
                  Positioned(
                    right: 20.0, bottom: 20.0,
                    child: SvgPicture.asset('assets/image/widget/bottom_bar/weight.svg'),
                  ),
                ],
              ),
            ),
            Container(
              height: 170.0.h,
              color: PTheme.tertiary[90],
              child: Stack(
                children: [
                  Positioned(
                    right: 20.0, top: 20.0,
                    child: PText('유산소 입력하기', style: textTheme.displaySmall),
                  ),
                  Positioned(
                    left: 20.0, bottom: 20.0,
                    child: SvgPicture.asset('assets/image/widget/bottom_bar/distance.svg'),
                  ),
                ],
              ),
            ),
            Container(
              height: 170.0.h,
              color: PTheme.tertiary[80],
              child: Stack(
                children: [
                  Positioned(
                    left: 20.0, top: 20.0,
                    child: PText('오른 계단 입력하기', style: textTheme.displaySmall),
                  ),
                  Positioned(
                    right: 20.0,
                    bottom: 20.0,
                    child: SvgPicture.asset('assets/image/widget/bottom_bar/height.svg'),
                  ),
                ],
              ),
            ),
            Container(
              height: 170.0.h,
              color: PTheme.tertiary[60],
              child: Stack(
                children: [
                  Positioned(
                    right: 20.0, top: 20.0,
                    child: PText('뺀 칼로리 입력하기', style: textTheme.displaySmall),
                  ),
                  Positioned(
                    left: 20.0,
                    bottom: 20.0,
                    child: SvgPicture.asset('assets/image/widget/bottom_bar/calorie.svg'),
                  ),
                ],
              ),
            ),
          ],
        ),
        collapsed: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                const SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.home, size: 40.0),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, size: 40.0),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.star, size: 40.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Container(
          color: PTheme.offWhite,
          child: const HomeView(),
        ),
      ),
    );
  }
}