import 'package:get/get.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/level.dart';
import 'package:pistachio/presenter/model/user.dart';

class RecordMain extends GetxController {
  static void toRecordMain() {
    final recordMain = Get.find<RecordMain>();
    Get.toNamed('/record/main');
    recordMain.loadTiers();
  }

  Map<ActivityType, Map<String, dynamic>> tiers = {};

  void loadTiers() {
    final userPresenter = Get.find<UserPresenter>();

    for (ActivityType type in ActivityType.values) {
      int amount = userPresenter.loggedUser.getAmounts(type);
      tiers[type] = LevelPresenter.getTier(type, amount);
    }
    update();
  }
}