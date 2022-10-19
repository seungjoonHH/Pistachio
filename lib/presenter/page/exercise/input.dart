import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/model/class/json/badge.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/health/health.dart';
import 'package:pistachio/presenter/model/collection.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/home.dart';

class ExerciseInput extends GetxController {
  static final inputCont = TextEditingController();

  static void toExerciseInput(ActivityType type) async {
    await GlobalPresenter.closeBottomBar();
    Get.toNamed('/exercise/input', arguments: type);
  }

  // Future completeButtonPressed(ActivityType type) async {
  //   final userPresenter = Get.find<UserPresenter>();
  //   bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;
  //   int amount = int.parse(inputCont.text);
  //   int converted = amount;
  //
  //   if (type == ActivityType.distance) {
  //     converted = convertDistance(amount);
  //     await HealthPresenter.addStepsData(int.parse(inputCont.text), converted);
  //   }
  //   if (type == ActivityType.height) {
  //     if (isIOS) {
  //       await HealthPresenter.addFlightsData(int.parse(inputCont.text));
  //     }

  Future<int> convertRecord(ActivityType type, int amount) async {
    bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;

    switch (type) {
      case ActivityType.distance:
        int converted =
            convertDistance(amount, DistanceUnit.minute, DistanceUnit.step);
        await HealthPresenter.addStepsData(
            int.parse(inputCont.text), converted);
        return converted;
      case ActivityType.height:
        if (isIOS) {
          await HealthPresenter.addFlightsData(int.parse(inputCont.text));
        }
        return amount;
      default:
        return amount;
    }
  }

  bool completed(ActivityType type) {
    final userPresenter = Get.find<UserPresenter>();

    int goal = userPresenter.loggedUser.goals[type.name];
    int value = userPresenter.loggedUser.getTodayAmounts(type);
    return goal <= value;
  }

  List<ActivityType> get completedActivities {
    List<ActivityType> types = [];
    for (ActivityType type in ActivityType.values.sublist(0, 3)) {
      if (completed(type)) types.add(type);
    }
    return types;
  }

  void addRecords(ActivityType type, int amount) async {
    final userPresenter = Get.find<UserPresenter>();
    late int converted, before, after;
    converted = await convertRecord(type, amount);
    before = completedActivities.length;

    userPresenter.loggedUser.addRecord(type, today, converted);
    userPresenter.loggedUser
        .addRecord(ActivityType.calorie, today, getCalories(type, amount));

    after = completedActivities.length;

    if (before != 3 && after == 3) awardDailyActivityCompleteBadge();

    userPresenter.save();
  }

  Future completeButtonPressed(ActivityType type) async {
    addRecords(type, int.parse(inputCont.text));

    inputCont.clear();
    HomePresenter.toHome();
    update();
  }

  void awardDailyActivityCompleteBadge() {
    final userPresenter = Get.find<UserPresenter>();
    Badge newBadge = BadgePresenter.getBadge('1000000')!;
    Badge badge = BadgePresenter.getBadge('1000001')!;

    for (Collection collection in userPresenter.myCollections) {
      if (collection.badgeId == badge.id) {
        GlobalPresenter.badgeAwarded(badge);
        collection.addDate(now);
        return;
      }
    }

    GlobalPresenter.badgeAwarded(badge, true);
    GlobalPresenter.badgeAwarded(newBadge, true);

    userPresenter.myCollections.add(Collection.fromJson({
      'badgeId': newBadge.id,
      'dates': [toTimestamp(now)],
    }));
    userPresenter.myCollections.add(Collection.fromJson({
      'badgeId': badge.id,
      'dates': [toTimestamp(now)],
    }));
  }
}
