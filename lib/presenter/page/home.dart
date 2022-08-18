import 'package:get/get.dart';
import 'package:pistachio/model/class/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';

class HomePresenter extends GetxController {
  static void toHome() {
    final homePresenter = Get.find<HomePresenter>();
    homePresenter.loadGoals();
    Get.offAllNamed('/home');
  }

  Map<ActivityType, int> myGoals = {};
  Map<ActivityType, int> myTodayRecords = {};

  void loadGoals() {
    final userPresenter = Get.find<UserPresenter>();
    PUser user = userPresenter.loggedUser;

    for (var type in ActivityType.values) {
      for (var goal in user.goals) {
        if (goal['type'] != type.kr) continue;
        myGoals[type] = goal['amount'].toInt();
      }
    }
  }

  void loadRecords() {
    final userPresenter = Get.find<UserPresenter>();
    PUser user = userPresenter.loggedUser;
    for (var type in ActivityType.values) {
      myTodayRecords[type] = user.getTodayAmounts(type);
    }
  }
}