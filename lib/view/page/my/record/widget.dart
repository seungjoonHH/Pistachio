import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/level.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:text_scroll/text_scroll.dart';

class MyRecordDetailView extends StatelessWidget {
  final ActivityType type;

  const MyRecordDetailView({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PUser loggedUser = Get.find<UserPresenter>().loggedUser;
    int amounts = loggedUser.getAmounts(type);

    if (type == ActivityType.distance) {
      amounts = convertDistance(
        amounts, DistanceUnit.step, DistanceUnit.kilometer,
      );
    }

    Map<String, dynamic> tier = LevelPresenter.getTier(type, amounts);
    int remainValue = tier['nextValue'] - amounts;

    if (type == ActivityType.distance) {
      remainValue = convertDistance(
        remainValue, DistanceUnit.kilometer, DistanceUnit.step,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          PText('현재 내 위치', style: textTheme.headlineSmall),
          const SizedBox(height: 10),
          TextScroll(
            tier['currentTitle'] ?? '',
            style: textTheme.displayLarge?.merge(TextStyle(
              color: type.color,
              fontWeight: FontWeight.normal,
            )),
          ),
          const SizedBox(height: 20),
          Image.network(
            height: 400.0,
            fit: BoxFit.fitHeight,
            'https://t1.daumcdn.net/cfile/tistory/990975445B3AD34237',
          ),
          const SizedBox(height: 20),
          PTexts([
            '$remainValue', type.unit, ' 더 ${type.suffix}'
          ], colors: [type.color, type.color, PTheme.black],
            style: textTheme.headlineSmall,
            space: false,
          ),
          PText('다음 단계로 올라갈 수 있어요!', style: textTheme.headlineSmall),
        ],
      ),
    );
  }
}
