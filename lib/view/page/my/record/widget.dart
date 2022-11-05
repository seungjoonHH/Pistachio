import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/user.dart';
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
    // if (type == ActivityType.distance) {
    //   amounts = convertDistance(
    //     amounts,
    //     DistanceUnit.step,
    //     DistanceUnit.kilometer,
    //   );
    // }

    Record nextValue = Record.init(
      type, tier['nextValue'].toDouble(), DistanceUnit.kilometer,
    );

    nextValue.convert(DistanceUnit.step);
    int remainValue = (nextValue.amount - amount).round();
    // if (type == ActivityType.distance) {
    //   remainValue = convertDistance(
    //     remainValue,
    //     DistanceUnit.kilometer,
    //     DistanceUnit.step,
    //   );
    // }

    return Column(
      children: [
        Stack(
          children: [
            const BackgroundTop(),
            const SunAndMoon(),
            const Clouds(start: 0.7, relativeDistance: 0.25),
            const Clouds(start: 0.6, relativeDistance: 0.5),
            const Clouds(start: 0.3, relativeDistance: 0),
            const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  width: 200,
                  height: 200,
                )),
            Positioned(
              left: 0,
              top: 200,
              width: 100,
              child: Image.asset('assets/image/record/rock.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 60.0),
                  PText('현재 내 위치', style: textTheme.headlineSmall),
                  const SizedBox(height: 10.0),
                  TextScroll(
                    tier['currentTitle'] ?? '',
                    style: textTheme.displayLarge?.merge(TextStyle(
                      color: type.color,
                      fontWeight: FontWeight.normal,
                    )),
                  ),
                  const SizedBox(height: 20.0),
                  Image.asset(
                    'assets/image/level/${type.name}/${tier['currentId']}.png',
                    width: 300.0.w,
                  ),
                  const SizedBox(height: 20.0),
                  PTexts(
                    ['$remainValue', type.unit, ' 더 ${type.ifDo}'],
                    colors: [type.color, type.color, PTheme.black],
                    style: textTheme.headlineSmall,
                    space: false,
                  ),
                  PText('다음 단계로 올라갈 수 있어요!', style: textTheme.headlineSmall),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}