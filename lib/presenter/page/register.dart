import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/view/page/register/widget.dart';
import 'home.dart';

class Field {
  bool invalid = false;
  dynamic controller;

  Field([this.controller]);
}

/// class
class RegisterPresenter extends GetxController {
  int pageIndex = 0;
  bool invalid = false;
  List<bool> imageExistence = [false, false, true, true, true, true, true];
  bool imageVisualize = false;

  Map<String, Field> fields = {
    'nickname': Field(TextEditingController()),
    'dateOfBirth': Field(TextEditingController()),
    'sex': Field(),
  };

  static const Duration shakeDuration = Duration(milliseconds: 500);

  static Curve transitionCurve = Curves.easeInOut;
  static const Duration transitionDuration = Duration(milliseconds: 350);

  /// static variables
  static final carouselCont = CarouselController();

  static void toRegister() {
    final registerPresenter = Get.find<RegisterPresenter>();
    registerPresenter.init();
    Get.toNamed('/register');
  }

  /// static methods
  // 컨트롤러를 모두 초기화
  void init() {
    for (var field in fields.values) { field.controller?.clear(); }
    newcomer = PUser();
    pageIndex = 0;
    distanceMinute = 0;
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

  int distanceMinute = 0;
  int weightPerDay = 0;

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
    newcomer.sex = value;
    update();
  }

  // 체중 설정
  void setWeight(int value) {
    newcomer.weight = value;
    update();
  }

  // 신장 설정
  void setHeight(int value) {
    newcomer.height = value;
    update();
  }

  void initGoal(ActivityType type, int value) async {
    newcomer.goals[type.name] = 0;
    if (type == ActivityType.distance) distanceMinute = 0;
    update();
    await Future.delayed(const Duration(milliseconds: 500), () {
      setGoal(type, value);
      update();
    });
  }

  void setGoal(ActivityType type, int value) {
    int amount = value;

    switch (type) {
      case ActivityType.distance:
        distanceMinute = amount;
        amount = convertDistance(amount);
        break;
      case ActivityType.weight:
        weightPerDay = amount * newcomer.weight!;
        break;
      default:
    }
    newcomer.goals[type.name] = amount;
  }

  // 새 크루 정보 제출 시
  void submitted() {
    final userPresenter = Get.find<UserPresenter>();
    newcomer.nickname = fields['nickname']!.controller.text;
    newcomer.dateOfBirth = stringToDate(fields['dateOfBirth']!.controller.text);

    userPresenter.login(newcomer);
    userPresenter.loggedUser.regDate = DateTime.now();

    // 파이어베이스에 저장
    userPresenter.save();
    HomePresenter.toHome();

    init();
  }

  void nicknameValidate() async {
    Field nicknameField = fields['nickname']!;
    String text = nicknameField.controller.text;

    if (text == '' || RegExp(r'[`~!@#$%^&*|"' r"'‘’””;:/?]").hasMatch(text)) {
      invalid = true;
      nicknameField.invalid = true; update();
      await Future.delayed(const Duration(milliseconds: 1000), () {
        nicknameField.invalid = false; update();
      });
    }
  }

  void dateOfBirthValidate() async {
    Field dateOfBirthField = fields['dateOfBirth']!;
    String text = dateOfBirthField.controller.text;
    DateTime? date = stringToDate(text);

    bool condition = text.length != 8;
    condition |= int.tryParse(text) == null;
    condition |= date == null;
    condition |= (today.year - (date?.year ?? 0)) > 99;

    if (condition) {
      invalid = true;
      dateOfBirthField.invalid = true; update();
      await Future.delayed(const Duration(milliseconds: 1000), () {
        dateOfBirthField.invalid = false; update();
      });
    }
  }

  void sexValidate() async {
    Field sexField = fields['sex']!;

    if (newcomer.sex == null) {
      invalid = true;
      sexField.invalid = true; update();
      await Future.delayed(const Duration(milliseconds: 1000), () {
        sexField.invalid = false; update();
      });
    }
  }

  void slideBack() async {
    imageVisualize = false;
    update();
    await Future.delayed(const Duration(milliseconds: 5), () {
      imageVisualize = imageExistence[pageIndex];
      update();
    });
  }
  void slideNext() async {
    imageVisualize = false;
    update();
    await Future.delayed(const Duration(milliseconds: 5), () {
      imageVisualize = imageExistence[pageIndex];
      update();
    });
  }

  // 다음 버튼 클릭 트리거
  void nextPressed() async {
    switch (pageIndex) {
      case 0:
        nicknameValidate();
        dateOfBirthValidate();
        sexValidate();
        if (invalid) { invalid = false; return; }
        newcomer.nickname = fields['nickname']!.controller.text;
        newcomer.dateOfBirth = stringToDate(fields['dateOfBirth']!.controller.text);
        break;
      case 1: break;
      case 2:
        initGoal(ActivityType.distance, 15);
        break;
      case 3: break;
      case 4:
        initGoal(ActivityType.height, 15);
        break;
      case 5:
        int goal = 0;
        for (var type in ActivityType.activeValues.sublist(1)) {
          int amount = newcomer.goals[type.name].toInt();
          if (type == ActivityType.distance) amount = distanceMinute;
          goal += getCalories(type, amount);
        }
        newcomer.goals[ActivityType.calorie.name] = goal;
        update();
        break;
      case 6:
        submitted(); return;
    }
    carouselCont.nextPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexIncrease();
    slideNext();
  }

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    if (pageIndex == 0) {
      final userPresenter = Get.find<UserPresenter>();
      userPresenter.logout();
      init();
      Get.offAllNamed('/login', arguments: true);
    }

    carouselCont.previousPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    slideBack();
    pageIndexDecrease();
  }
}
