import 'package:get/get.dart';
import 'package:pistachio/model/enum/activity_type.dart';
import 'package:pistachio/model/enum/distance_unit.dart';
import 'package:pistachio/presenter/model/level.dart';
import 'package:pistachio/presenter/model/record.dart';
import 'package:pistachio/presenter/model/user.dart';

/// class
class RecordMain extends GetxController {
  /// static methods
  // 기록 메인 페이지로 이동
  static void toRecordMain() {
    final recordMain = Get.find<RecordMain>();
    Get.toNamed('/record/main');
    recordMain.loadTiers();
  }

  /// attributes
  Map<ActivityType, Map<String, dynamic>> tiers = {};

  /// methods
  //
  void loadTiers() {
    final userP = Get.find<UserPresenter>();

    for (ActivityType type in ActivityType.activeValues) {
      double amount = userP.loggedUser.getAmounts(type);
      Record record = Record.init(type, amount, DistanceUnit.kilometer);

      tiers[type] = LevelPresenter.getTier(type, record);
    }
    update();
  }
}