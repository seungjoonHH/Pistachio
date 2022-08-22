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