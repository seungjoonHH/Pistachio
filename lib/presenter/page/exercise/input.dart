import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/home.dart';

import '../../health/health.dart';

class ExerciseInput extends GetxController {
  static final inputCont = TextEditingController();

  static void toExerciseInput(ActivityType type) {
    Get.toNamed('/exercise/input', arguments: type);
  }

  Future completeButtonPressed(ActivityType type) async {
    final userPresenter = Get.find<UserPresenter>();
    int amount = int.parse(inputCont.text);
    int converted = amount;

    if (type == ActivityType.distance) {
      converted = convertDistance(amount);
      await HealthPresenter.addData(int.parse(inputCont.text), converted);
    }
    if (type == ActivityType.weight) converted = convertWeight(amount);

    userPresenter.loggedUser.addRecord(type, today, converted);
    userPresenter.loggedUser.addRecord(ActivityType.calorie, today, getCalories(type, amount));
    userPresenter.save();
    inputCont.clear();
    HomePresenter.toHome();
    update();
  }
}
