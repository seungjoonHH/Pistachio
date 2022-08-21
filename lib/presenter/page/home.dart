import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/class/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';

class HomePresenter extends GetxController {
  static void toHome() {
    final homePresenter = Get.find<HomePresenter>();
    homePresenter.init();
    Get.offAllNamed('/home');
  }

  void init() {
    final userPresenter = Get.find<UserPresenter>();
    userPresenter.load();

    graphStates = {
      ActivityType.distance: false,
      ActivityType.height: false,
      ActivityType.weight: false,
      ActivityType.calorie: false,
    };
    loadGoals();
    loadRecords();
  }

  late Map<ActivityType, bool> graphStates = {
    ActivityType.distance: false,
    ActivityType.height: false,
    ActivityType.weight: false,
    ActivityType.calorie: false,
  };

  void showLaterGraph(ActivityType type) { graphStates[type] = true; update(); }

  Map<ActivityType, int> myGoals = {};
  Map<ActivityType, int> todayRecords = {};
  Map<ActivityType, int> thisMonthRecords = {};

  void loadGoals() {
    final userPresenter = Get.find<UserPresenter>();
    PUser user = userPresenter.loggedUser;

    for (var type in ActivityType.values) {
      myGoals[type] = user.goals[type.name].toInt();
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
        todayRecords[type] = ((todayRecords[type] ?? 0) / user.weight!).ceil();
        thisMonthRecords[type] = ((thisMonthRecords[type] ?? 0) / user.weight!).ceil();
      }
    }
    update();
  }

}