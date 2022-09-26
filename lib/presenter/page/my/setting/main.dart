import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/firebase/auth/auth.dart';
import 'package:pistachio/view/widget/function/dialog.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class MySettingMain extends GetxController {
  static void toMySettingMain() => Get.toNamed('my/setting/main');
  static void logoutButtonPressed() => AuthPresenter.pLogout();
  static void accountDeleteButtonPressed() {
    showPDialog(
      type: DialogType.bi,
      title: '계정 삭제',
      titlePadding: const EdgeInsets.all(20.0),
      content: PText('정말 계정을 삭제하시겠습니까?'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      rightText: '삭제',
      leftPressed: Get.back,
      rightPressed: AuthPresenter.pDeleteAccount,
      rightColor: Colors.red,
    );
  }
}