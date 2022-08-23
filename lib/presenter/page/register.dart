import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/class/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';
import '../../view/page/register/widget.dart';
import 'home.dart';
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

  static void toRegister() => Get.toNamed('/register');

  /// static methods
  // 컨트롤러를 모두 초기화
  void clearConts() {
    nickNameCont.clear();
    birthdayCont.clear();
    newcomer = PUser();
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

  int distanceMinute = 15;

  // List<Map<String, String>> examples = [
  //   {
  //     'name': '감자튀김',
  //     'kcal': '331kal',
  //     'image':
  //         'https://previews.123rf.com/images/rainart123/rainart1231610/rainart123161000053/67577359-%EA%B0%90%EC%9E%90-%ED%8A%80%EA%B9%80-%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8-%EB%B2%A1%ED%84%B0.jpg'
  //   },
  //   {
  //     'name': '탄산음료',
  //     'kcal': '108kal',
  //     'image':
  //         'https://w7.pngwing.com/pngs/69/20/png-transparent-three-coca-cola-fanta-and-sprite-disposable-cups-fizzy-drinks-coca-cola-sprite-fanta-shawarma-fanta-food-chicken-meat-cola.png'
  //   },
  //   {
  //     'name': '공깃밥',
  //     'kcal': '313kal',
  //     'image':
  //         'https://e7.pngegg.com/pngimages/973/964/png-clipart-jasmine-rice-cooked-rice-white-rice-basmati-translucent-food-cereal.png'
  //   },
  // ];
  //
  Map<String, String> example = {
    'name': '공깃밥',
    'kcal': '313kal',
    'image':
        'https://e7.pngegg.com/pngimages/973/964/png-clipart-jasmine-rice-cooked-rice-white-rice-basmati-translucent-food-cereal.png'
  };

  /// methods
  // 성별 설정
  void setSex(Sex? value) {
    if (value == null) return;
    newcomer.sex = value; update();
  }

  // 체중 설정
  void setWeight(int value) {
    newcomer.weight = value; update();
  }

  // 신장 설정
  void setHeight(int value) {
    newcomer.height = value; update();
  }

  void setGoal(ActivityType type, int value) {
    int goal = value;

    if (type == ActivityType.distance) {
      distanceMinute = value;
      goal = convertAmount(type, value);
    }

    newcomer.goals[type.name] = goal; update();
  }

  // 새 크루 정보 제출 시
  void submitted() {
    final userPresenter = Get.find<UserPresenter>();

    newcomer.nickname = nickNameCont.text;
    newcomer.dateOfBirth = DateTime.utc(
      int.parse(birthdayCont.text.substring(0, 4)),
      int.parse(birthdayCont.text.substring(4, 6)),
      int.parse(birthdayCont.text.substring(6)),
    );

    userPresenter.login(newcomer);
    userPresenter.loggedUser.regDate = DateTime.now();

    // 파이어베이스에 저장
    userPresenter.save();
    HomePresenter.toHome();

    clearConts();
  }

  // 다음 버튼 클릭 트리거
  void nextPressed() {
    if (pageIndex == 0) {
      bool nicknameInvalid = nickNameCont.text == '';
      nicknameInvalid |= RegExp(r'[`~!@#$%^&*|"' r"'‘’””;:/?]")
          .hasMatch(nickNameCont.text);
      bool birthdayInvalid = birthdayCont.text.length != 8;
      birthdayInvalid |= int.tryParse(birthdayCont.text) == null;
      bool sexInvalid = (newcomer.sex == null);

      bool invalid = nicknameInvalid || birthdayInvalid || sexInvalid;

      if (invalid) {
        if (nicknameInvalid) validate(0);
        if (birthdayInvalid) validate(1);
        if (sexInvalid) validate(2);
        return;
      }
      newcomer.nickname = nickNameCont.text;
      newcomer.dateOfBirth = DateTime.utc(
        int.parse(birthdayCont.text.substring(0, 4)),
        int.parse(birthdayCont.text.substring(4, 6)),
        int.parse(birthdayCont.text.substring(6)),
      );
    } else if (pageIndex == 6) {
      newcomer.goals[ActivityType.calorie.name] = allCalories;
      update();
    } else if (pageIndex == CarouselView.widgetCount - 1) {
      submitted();
      return;
    }
    carouselCont.nextPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexIncrease();
  }

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    if (pageIndex == 0) {
      final userPresenter = Get.find<UserPresenter>();
      userPresenter.logout();
      clearConts();
      Get.offAllNamed('/login', arguments: true);
    }

    carouselCont.previousPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexDecrease();
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
