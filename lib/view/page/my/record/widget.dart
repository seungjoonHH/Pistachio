import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/enum/enum.dart';
import '../../../../global/theme.dart';
import '../../../../model/class/database/user.dart';
import '../../../../presenter/model/level.dart';
import '../../../../presenter/model/user.dart';
import '../../../widget/widget/text.dart';

class MyRecordDetailView extends StatelessWidget {
  final ActivityType type;

  const MyRecordDetailView({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PUser loggedUser = Get.find<UserPresenter>().loggedUser;
    Map<String, dynamic> tier =
        LevelPresenter.getTier(type, loggedUser.getAmounts(type));

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          PText('현재 내 위치', style: textTheme.headlineSmall),
          const SizedBox(height: 10),
          PText(
            '에펠탑',
            style: textTheme.displayLarge,
            color: type.color,
          ),
          const SizedBox(height: 20),
          Image.network(
            height: 400.0,
            fit: BoxFit.fitHeight,
            'https://t1.daumcdn.net/cfile/tistory/990975445B3AD34237',
          ),
          const SizedBox(height: 20),
          PTexts(
            ['20', type.unit, '을 오르면'],
            colors: [type.color, type.color, PTheme.black],
            style: textTheme.headlineSmall,
            space: false,
          ),
          PText('다음 단계로 올라갈 수 있어요!', style: textTheme.headlineSmall),
        ],
      ),
    );
  }
}
