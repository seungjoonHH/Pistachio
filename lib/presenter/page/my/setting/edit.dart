import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/presenter/model/user.dart';

/// class
class MySettingEdit extends GetxController {
  /// static variables
  static Map<String, String> kr = {
    'nickname': '별명',
    'height': '신장',
    'weight': '체중',
  };
  static final editConts = {
    'nickname': TextEditingController(),
    'height': TextEditingController(),
    'weight': TextEditingController(),
  };

  /// static methods
  // 내 설정 수정 페이지
  static void toMySettingEdit(String editType) {
    final userP = Get.find<UserPresenter>();
    PUser user = userP.loggedUser;

    editConts['nickname']?.text = user.nickname!;
    editConts['height']?.text = '$height';
    editConts['weight']?.text = '$weight';
    Get.toNamed('my/setting/edit', arguments: editType);
  }

  /// attributes

  /// methods
  // 입력 컨트롤러 초기화
  void clearConts() {
    for (var cont in editConts.values) { cont.clear(); }
  }

  // 제출 시
  void submit() {
    final userP = Get.find<UserPresenter>();
    PUser user = userP.loggedUser;

    user.nickname = editConts['nickname']!.text;
    user.height = int.parse(editConts['height']!.text);
    user.weight = int.parse(editConts['weight']!.text);

    userP.update();
    userP.save();
    Get.back();
  }


}