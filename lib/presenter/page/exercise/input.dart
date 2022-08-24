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

    if (type == ActivityType.distance) {
      amount = convertDistance(amount);
      await HealthPresenter.addData(int.parse(inputCont.text), amount);
    }
    if (type == ActivityType.weight) amount = convertWeight(amount);

    userPresenter.loggedUser.addRecord(type, today, amount);
    userPresenter.loggedUser
        .addRecord(ActivityType.calorie, today, calories[type] ?? 0);
    userPresenter.save();
    inputCont.clear();
    HomePresenter.toHome();
    update();
  }
}
