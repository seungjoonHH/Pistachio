import 'package:get/get.dart';
import 'package:pistachio/model/class/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';

class HomePresenter extends GetxController {
  static void toHome() {
    final homePresenter = Get.find<HomePresenter>();
    homePresenter.loadGoals();
    homePresenter.loadRecords();
    Get.offAllNamed('/home');
  }

  Map<ActivityType, int> myGoals = {};
  Map<ActivityType, int> todayRecords = {};
  Map<ActivityType, int> thisMonthRecords = {};

  void loadGoals() {
    final userPresenter = Get.find<UserPresenter>();
    PUser user = userPresenter.loggedUser;

    for (var type in ActivityType.values) {
      for (var goal in user.goals) {
        if (goal['type'] != type.kr) continue;
        myGoals[type] = goal['amount'].toInt();
      }
    }
    update();
  }

  void loadRecords() {
    final userPresenter = Get.find<UserPresenter>();
    PUser user = userPresenter.loggedUser;
    for (var type in ActivityType.values) {
      todayRecords[type] = user.getTodayAmounts(type);
      thisMonthRecords[type] = user.getAmounts(type);
      if (type == ActivityType.weight) {
        todayRecords[type] = (todayRecords[type]! / user.weight!).ceil();
        thisMonthRecords[type] = (thisMonthRecords[type]! / user.weight!).ceil();
      }
    }
    update();
  }

}