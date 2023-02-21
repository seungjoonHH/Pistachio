import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/string.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/class/json/level.dart';
import 'package:pistachio/model/enum/activity_type.dart';
import 'package:pistachio/model/enum/unit.dart';
import 'package:pistachio/presenter/model/level.dart';
import 'package:pistachio/presenter/model/record.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/my/record/main.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:text_scroll/text_scroll.dart';
import 'background/layout/components/background_top.dart';
import 'background/layout/components/clouds.dart';
import 'background/layout/components/sun.dart';

class MyRecordDetailView extends StatelessWidget {
  final ActivityType type;

  const MyRecordDetailView({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    PUser loggedUser = Get.find<UserPresenter>().loggedUser;
    double amount = loggedUser.getAmounts(type);
    Record record = Record.init(type, amount, ExerciseUnit.step);

    Map<String, dynamic> tier = LevelPresenter.getTier(type, record);
    Level current = tier['current'];
    Level next = tier['next'];

    Record nextValue = Record.init(
      type, next.amount!.toDouble(),
      ExerciseUnit.kilometer,
    );

    nextValue.convert(ExerciseUnit.step);

    return Stack(
      children: [
        GetBuilder<MyRecordMain>(
          builder: (controller) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: const [
                    BackgroundTop(),
                    SunAndMoon(),
                    Clouds(start: .7, relativeDistance: .25),
                    Clouds(start: .6, relativeDistance: .5),
                    Clouds(start: .3, relativeDistance: .0),
                  ],
                ),
                Positioned(
                  left: 0, top: 200.0, width: 100.0,
                  child: Image.asset('assets/image/record/rock.png'),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 3000),
                  top: controller.animating ? 250.0.h : 200.0.h,
                  curve: Curves.elasticOut,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 1000),
                    opacity: controller.fading ? 1.0 : .0,
                    child: Center(
                      child: Draggable(
                        feedback: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/image/level/${type.name}/${current.id}.png',
                            width: 170.0.w,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        onDragStarted: controller.endAnimation,
                        onDragEnd: (_) => controller.startAnimation(),
                        child: controller.animating ? Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/image/level/${type.name}/${current.id}.png',
                            width: 170.0.w,
                            fit: BoxFit.fitWidth,
                          ),
                        ) : Container(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 140.0.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PTexts(['${loggedUser.nickname}', '님은'],
                        colors: const [PTheme.colorD, PTheme.black],
                        style: textTheme.headlineMedium,
                      ),
                      PTexts([
                        '총 ', '${loggedUser.getAmounts(type).round()}${type.unitAlt}',
                        '${eulReul(type.unitAlt)} ${type.did}',
                      ], colors: [PTheme.black, type.color, PTheme.black],
                        style: textTheme.headlineMedium,
                        space: false,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        Container(
          alignment: Alignment.center,
          height: 800.0.h,
          padding: EdgeInsets.fromLTRB(20.0.w, 70.0.h, 20.0.w, 40.0.h),
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
                      shadows: const [Shadow(
                        blurRadius: 20.0,
                        color: PTheme.white,
                      )],
                    )),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: PText('${current.description}',
                  style: textTheme.titleMedium,
                  maxLines: 6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}