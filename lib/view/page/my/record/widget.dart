import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/class/json/level.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/level.dart';
import 'package:pistachio/presenter/model/record.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:text_scroll/text_scroll.dart';
import 'background/layout/components/background_top.dart';
import 'background/layout/components/clouds.dart';
import 'background/layout/components/sun.dart';

class MyRecordDetailView extends StatelessWidget {
  final ActivityType type;

  const MyRecordDetailView({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    PUser loggedUser = Get.find<UserPresenter>().loggedUser;
    double amount = loggedUser.getAmounts(type);
    Record record = Record.init(type, amount, DistanceUnit.step);

    Map<String, dynamic> tier = LevelPresenter.getTier(type, record);
    Level current = tier['current'];
    Level next = tier['next'];

    Record nextValue = Record.init(
      type, next.amount!.toDouble(), DistanceUnit.kilometer,
    );

    nextValue.convert(DistanceUnit.step);

    return Stack(
      children: [
        Stack(
          children: [
            const BackgroundTop(),
            const SunAndMoon(),
            const Clouds(start: .7, relativeDistance: .25),
            const Clouds(start: .6, relativeDistance: .5),
            const Clouds(start: .3, relativeDistance: .0),
            Positioned(
              left: 0, top: 200.0, width: 100.0,
              child: Image.asset('assets/image/record/rock.png'),
            ),
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/image/level/${type.name}/${current.id}.png',
                width: 300.0.w,
                height: 300.0.h,
              ).animate().fadeIn().move(
                duration: const Duration(milliseconds: 3000),
                begin: const Offset(0.0, -40.0),
                end: const Offset(0.0, 0.0),
                curve: Curves.elasticOut,
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          height: 800.0.h,
          padding: EdgeInsets.symmetric(
            horizontal: 20.0.w,
            vertical: 70.0.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  PText('현재 내 위치', style: textTheme.headlineSmall),
                  SizedBox(height: 10.0.h),
                  TextScroll(
                    current.title ?? '',
                    intervalSpaces: 5,
                    style: textTheme.displayLarge?.merge(TextStyle(
                      color: type.color,
                      fontWeight: FontWeight.normal,
                    )),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: PText('${current.description}',
                  style: textTheme.titleLarge,
                  maxLines: 8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}