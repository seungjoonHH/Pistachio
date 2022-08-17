// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../model/class/user.dart';
// import '../../view/page/register/widget.dart';
// import '../firebase/login/login.dart';
// import '../model/user.dart';
//
// // 회원가입 페이지 프리젠터
// class RegisterPresenter extends GetxController {
//   int pageIndex = 0;
//   List<bool> invalids = [false, false, false];
//
//   static const Duration shakeDuration = Duration(milliseconds: 500);
//
//   static Curve transitionCurve = Curves.fastOutSlowIn;
//   static const Duration transitionDuration = Duration(milliseconds: 300);
//
//   static final userPresenter = Get.find<UserPresenter>();
//
//   static final nicknameCont = TextEditingController();
//   static final dateOfBirthCont = TextEditingController();
//   static final carouselCont = CarouselController();
//
//   // 현재 페이지 인덱스 증가
//   void pageIndexIncrease() {
//     if (pageIndex < CarouselView.widgetCount - 1) pageIndex++;
//     update();
//   }
//
//   // 현재 페이지 인덱스 감소
//   void pageIndexDecrease() {
//     if (pageIndex > 0) pageIndex--;
//     update();
//   }
//
//   // 뒤로가기 버튼 클릭 트리거
//   void backPressed() {
//     if (pageIndex == 0) {
//       LoginPresenter.fwLogout();
//       Get.offAllNamed('/greeting', arguments: true);
//     }
//
//     carouselCont.previousPage(
//       curve: transitionCurve,
//       duration: transitionDuration,
//     );
//     pageIndexDecrease();
//   }
//
//   // 다음 버튼 클릭 트리거
//   void nextPressed() {
//     if (pageIndex == 0) {
//       bool nicknameInvalid = nicknameCont.text == '';
//       nicknameInvalid |=
//           RegExp(r'[`~!@#$%^&*|"' r"'‘’””;:/?]").hasMatch(nicknameCont.text);
//       bool dateOfBirthInvalid = dateOfBirthCont.text.length != 6;
//       dateOfBirthInvalid |= int.tryParse(dateOfBirthCont.text) == null;
//       dateOfBirthInvalid |= PUser.stringToDate(dateOfBirthCont.text) == null;
//       bool sexInvalid = userPresenter.loggedUser.sex == null;
//
//       bool invalid = nicknameInvalid || dateOfBirthInvalid || sexInvalid;
//
//       if (invalid) {
//         if (nicknameInvalid) validate(0);
//         if (dateOfBirthInvalid) validate(1);
//         if (sexInvalid) validate(2);
//         return;
//       }
//       nicknameSubmitted(nicknameCont.text);
//       dateOfBirthChanged(PUser.stringToDate(dateOfBirthCont.text)!);
//     } else if (pageIndex == CarouselView.widgetCount - 1) {
//       userPresenter.setInitWeight();
//       nicknameCont.clear();
//       dateOfBirthCont.clear();
//       UserPresenter.updateDB(userPresenter.user);
//       return;
//     }
//
//     carouselCont.nextPage(
//       curve: transitionCurve,
//       duration: transitionDuration,
//     );
//     pageIndexIncrease();
//   }
//
//   // 잘못되었을 때 효과 트리거
//   void validate(index) async {
//     invalids[index] = true;
//     update();
//     await Future.delayed(shakeDuration, () {
//       invalids[index] = false;
//       update();
//     });
//   }
//
//   // 닉네임 제출 버튼 클릭 트리거 (닉네임 인풋 박스에서 Enter 버튼 클릭 트리거)
//   void nicknameSubmitted(String value) {
//     userPresenter.nickname = value;
//     update();
//   }
//
//   // 역할 선택 버튼 트리거
//   void roleSelected(Role role) {
//     if (role != userPresenter.user.role) userPresenter.toggleRole();
//     update();
//   }
//
//   // 성별 선택 버튼 트리거
//   void sexSelected(Sex sex) {
//     userPresenter.setSex(sex);
//     update();
//   }
//
//   // 생년월일 변경 트리거
//   void dateOfBirthChanged(DateTime dateOfBirth) {
//     userPresenter.user.dateOfBirth = dateOfBirth;
//     update();
//   }
//
//   // 체중 변경 트리거
//   void weightChanged(double weight) {
//     userPresenter.currentWeight = weight;
//     update();
//   }
//
//   // 신장 변경 트리거
//   void heightChanged(double height) {
//     userPresenter.user.height = height;
//     update();
//   }
// }

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/class/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';
import '../../view/page/register/widget.dart';
import 'main.dart';

/// class
class RegisterPresenter extends GetxController {
  int pageIndex = 0;
  List<bool> invalids = [false, false, false];

  static const Duration shakeDuration = Duration(milliseconds: 500);

  static Curve transitionCurve = Curves.fastOutSlowIn;
  static const Duration transitionDuration = Duration(milliseconds: 300);

  /// static variables
  // 유저 닉네임 텍스트 수정 컨트롤러
  static final nickNameCont = TextEditingController();

  // 유저 생년월일 텍스트 수정 컨트롤러
  static final birthdayCont = TextEditingController();

  static final carouselCont = CarouselController();

  /// static methods
  // 컨트롤러를 모두 초기화
  void clearConts() {
    nickNameCont.clear();
    birthdayCont.clear();
  }

  // 회원가입 페이지로 이동
  static void toRegister() {
    final registerPresenter = Get.find<RegisterPresenter>();
    Get.toNamed('/register');
    registerPresenter.newcomer = PUser();
  }

  // 현재 페이지 인덱스 증가
  void pageIndexIncrease() {
    if (pageIndex < CarouselView.widgetCount - 1) pageIndex++;
    update();
  }

  // 현재 페이지 인덱스 감소
  void pageIndexDecrease() {
    if (pageIndex > 0) pageIndex--;
    update();
  }

  /// attributes
  // 추가될 유저
  PUser newcomer = PUser();

  // 성별
  Sex? sex = Sex.male;

  // 체중
  int? weight = 0;

  // 신장
  int? height = 0;

  /// methods
  // 성별 설정
  void setSex(Sex? value) {
    if (value == null) return;
    sex = value;
    update();
  }

  // 체중 변경 트리거
  void weightChanged(int value) {
    weight = value;
    update();
  }

  // 신장 변경 트리거
  void heightChanged(int value) {
    height = value;
    update();
  }

  // 새 크루 정보 제출 시
  void submitted() {
    final userPresenter = Get.find<UserPresenter>();

    newcomer.nickname = nickNameCont.text;
    newcomer.sex = sex;
    newcomer.height = height;
    newcomer.weight = weight;
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

  // 다음 버튼 클릭 트리거
  void nextPressed() {
    if (pageIndex == 0) {
      bool nicknameInvalid = nickNameCont.text == '';
      nicknameInvalid |=
          RegExp(r'[`~!@#$%^&*|"' r"'‘’””;:/?]").hasMatch(nickNameCont.text);
      bool birthdayInvalid = birthdayCont.text.length != 8;
      birthdayInvalid |= int.tryParse(birthdayCont.text) == null;
      birthdayInvalid |= PUser.stringToDate(birthdayCont.text) == null;
      bool sexInvalid = (sex == null);

      bool invalid = nicknameInvalid || birthdayInvalid || sexInvalid;

      if (invalid) {
        if (nicknameInvalid) validate(0);
        if (birthdayInvalid) validate(1);
        if (sexInvalid) validate(2);
        return;
      }
      newcomer.nickname = nickNameCont.text;
      newcomer.sex = sex;
      newcomer.dateOfBirth = DateTime.utc(
        int.parse(birthdayCont.text.substring(0, 4)),
        int.parse(birthdayCont.text.substring(4, 6)),
        int.parse(birthdayCont.text.substring(6)),
      );
    } else if (pageIndex == CarouselView.widgetCount - 1) {
      final userPresenter = Get.find<UserPresenter>();
      userPresenter.login(newcomer);

      // 파이어베이스에 저장
      userPresenter.save();
      MainPresenter.toMain();
      return;
    }

    carouselCont.nextPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexIncrease();
  }

  // 잘못되었을 때 효과 트리거
  void validate(index) async {
    invalids[index] = true;
    update();
    await Future.delayed(shakeDuration, () {
      invalids[index] = false;
      update();
    });
  }
}
