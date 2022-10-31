import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/firebase/auth/auth.dart';
import 'package:pistachio/view/widget/function/dialog.dart';
import 'package:pistachio/view/widget/widget/text.dart';

/// class
class MySettingMain extends GetxController {
  /// static methods
  // 내 설정 메인 페이지로 이동
  static Future<bool> toMySettingMain() async {
    return await Get.toNamed('my/setting/main');
  }

  // 로그아웃 버튼 클릭 시
  static void logoutButtonPressed() => AuthPresenter.pLogout();

  // 계정 삭제 버튼 클릭 시
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