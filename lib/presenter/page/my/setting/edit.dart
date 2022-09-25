import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/presenter/model/user.dart';

class MySettingEdit extends GetxController {
  static final editConts = {
    'nickname': TextEditingController(),
    'height': TextEditingController(),
    'weight': TextEditingController(),
  };

  static void toMySettingEdit(String editType) {
    final userPresenter = Get.find<UserPresenter>();

    editConts['nickname']?.text = userPresenter.loggedUser.nickname!;
    editConts['height']?.text = '$height';
    editConts['weight']?.text = '$weight';
    Get.toNamed('my/setting/edit', arguments: editType);
  }

  void clearConts() {
    for (var cont in editConts.values) { cont.clear(); }
  }

  void submit() {
    final userPresenter = Get.find<UserPresenter>();

    userPresenter.loggedUser.nickname = editConts['nickname']!.text;
    userPresenter.loggedUser.height = int.parse(editConts['height']!.text);
    userPresenter.loggedUser.weight = int.parse(editConts['weight']!.text);

    userPresenter.update();
    Get.back();
  }


}