import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/home.dart';

class ExerciseInput extends GetxController {
  static final inputCont = TextEditingController();

  static void toExerciseInput(ActivityType type) {
    Get.toNamed('/exercise/input', arguments: type);
  }

  Map<ActivityType, int> get calories => {
    ActivityType.distance: Jogging.calorie,
    ActivityType.height: StairClimbing.calorie,
    ActivityType.weight: MuscularExercise.calorie,
  };

  int convertAmount(ActivityType type, int amount) {
    switch (type) {
      case ActivityType.distance:
        return (amount * Jogging.velocity).ceil();
      case ActivityType.weight:
        return (amount * weight).ceil();
      default:
        return amount;
    }
  }

  void completeButtonPressed(ActivityType type) {
    final userPresenter = Get.find<UserPresenter>();

    int amount = convertAmount(type, int.parse(inputCont.text));
    userPresenter.loggedUser.setRecord(type, today, amount);
    userPresenter.loggedUser.setRecord(ActivityType.calorie, today, calories[type] ?? 0);
    userPresenter.save();
    inputCont.clear();
    HomePresenter.toHome();
    update();
  }
}