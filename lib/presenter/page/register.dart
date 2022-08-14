import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/user.dart';
import '../model/user.dart';
import 'main.dart';

/// class
class RegisterPresenter extends GetxController {
  /// static variables
  // 유저 닉네임 텍스트 수정 컨트롤러
  static final nickNameCont = TextEditingController();

  // 유저 키 수정 컨트롤러
  static final heightCont = TextEditingController();

  // 유저 몸무게 텍스트 수정 컨트롤러
  static final weightCont = TextEditingController();

  // 유저 생년월일 텍스트 수정 컨트롤러
  static final birthdayCont = TextEditingController();

  /// static methods
  // 컨트롤러를 모두 초기화
  void clearConts() {
    nickNameCont.clear();
    heightCont.clear();
    weightCont.clear();
    birthdayCont.clear();
  }

  // 회원가입 페이지로 이동
  static void toRegister() {
    final registerPresenter = Get.find<RegisterPresenter>();
    Get.toNamed('/register');
    registerPresenter.newcomer = PUser();
  }

  /// attributes
  // 추가될 유저
  PUser newcomer = PUser();

  // 성별
  Sex sex = Sex.male;

  /// methods
  // 성별 설정
  void setSex(Sex? value) {
    if (value == null) return;
    sex = value;
    update();
  }

  // 새 크루 정보 제출 시
  void submitted() {
    final userPresenter = Get.find<UserPresenter>();

    newcomer.nickname = nickNameCont.text;
    newcomer.sex = sex;
    newcomer.height = double.parse(heightCont.text);
    newcomer.weight = double.parse(weightCont.text);
    newcomer.dateOfBirth = DateTime.utc(
      int.parse(birthdayCont.text.substring(0, 4)),
      int.parse(birthdayCont.text.substring(4, 6)),
      int.parse(birthdayCont.text.substring(6)),
    );

    userPresenter.login(newcomer);

    // 파이어베이스에 저장
    userPresenter.save();
    MainPresenter.toMain();

    clearConts();
  }
}
