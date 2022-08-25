/* 설정 페이지 프리젠터 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/firebase/auth/auth.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/view/widget/function/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 설정 페이지 프리젠터
class SettingPresenter extends GetxController {
  /// static variables
  // 닉네임 텍스트 수정 컨트롤러
  static final nicknameCont = TextEditingController();

  // 신장 텍스트 수정 컨트롤러
  static final heightCont = TextEditingController();

  // 체중 텍스트 수정 컨트롤러
  static final weightCont = TextEditingController();

  /// static methods
  // 설정 페이지로 이동
  static void toSetting() => Get.toNamed('/setting');

  // 뱃지 수정 버튼 클릭 시
  static void imageEditButtonPressed() => showBedgeSelectionModalSheet();

  // 로그아웃 버튼 클릭 시
  static void logoutButtonPressed() => AuthPresenter.pLogout();

  // 계정 삭제 버튼 클릭 시
  static void accountDeleteButtonPressed() => showDeleteAccountConfirmDialog();

  // 사진 추가 방식 선택 모달 시트 표시
  static void showBedgeSelectionModalSheet() {
    Map<String, VoidCallback> buttonData = {
      '카메라': Get.back,
      '갤러리': Get.back,
    };
    showFWModalBottomSheet(buttonData);
  }

  // 계정삭제 확인 창 표시
  static void showDeleteAccountConfirmDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('계정 삭제 확인'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const [Text('계정을 정말 삭제하시겠습니까?')],
          ),
        ),
        actions: [
          TextButton(
            onPressed: AuthPresenter.pDeleteAccount,
            child: Text('확인',
              style: TextStyle(color: colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  /// methods
  // 닉네임 제출 시
  void nicknameSubmitted() {
    final userPresenter = Get.find<UserPresenter>();

    if (nicknameCont.text == '') return;
    userPresenter.loggedUser.nickname = nicknameCont.text;
    userPresenter.save();
    nicknameCont.clear();
    Get.back();
    update();
  }

  // 신장 제출 시
  void heightSubmitted() {
    final userPresenter = Get.find<UserPresenter>();

    if (heightCont.text == '') return;
    userPresenter.loggedUser.height = int.parse(heightCont.text);
    userPresenter.save();
    heightCont.clear();
    Get.back();
    update();
  }

  // 체중 제출 시
  void weightSubmitted() {
    final userPresenter = Get.find<UserPresenter>();

    if (weightCont.text == '') return;
    userPresenter.loggedUser.weight = int.parse(weightCont.text);
    userPresenter.save();
    weightCont.clear();
    Get.back();
    update();
  }
}