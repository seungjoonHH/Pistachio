import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/string.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/view/page/register/widget.dart';
import 'home.dart';

class Field {
  bool invalid = false;
  String? hintText;
  dynamic controller;

  Field([this.controller]);
}

/// class
class RegisterPresenter extends GetxController {
  int pageIndex = 0;
  bool invalid = false;
  List<bool> imageExistence = [false, false, false, true, true, true, true, true];
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

  bool keyboardVisible = false;

  void setKeyboardVisible(bool value) {
    keyboardVisible = value;
    update();
  }

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
        amount = convertDistance(amount, DistanceUnit.minute, DistanceUnit.step);
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

    Map<String, bool> conditions = {
      '두 글자 이상 입력해주세요': text.length < 2,
      '열 글자 이하 입력해주세요': text.length > 10,
      '자음 모음은 단독으로 포함될 수 없습니다': hasSeparatedConsonantOrVowel(text),
      '공백을 포함할 수 없습니다': text.contains(' '),
      '특수문자는 포함할 수 없습니다': RegExp(r'[`~!@#$%^&*|"' r"'‘’””;:/?]").hasMatch(text),
      '영어나 한글을 포함해주세요': int.tryParse(text) != null,
      '별명을 입력해주세요': text == '',
    };

    conditions.forEach((message, condition) {
      if (condition) nicknameField.hintText = message;
    });

    if (conditions.values.any((condition) => condition)) {
      invalid = true;
      nicknameField.controller.clear();
      nicknameField.invalid = true; update();
      await Future.delayed(const Duration(milliseconds: 500), () {
        nicknameField.invalid = false; update();
      });
      await Future.delayed(const Duration(milliseconds: 500), () {
        nicknameField.controller.text = text; update();
        nicknameField.hintText = null;
      });
    }
  }

  void dateOfBirthValidate() async {
    Field dateOfBirthField = fields['dateOfBirth']!;
    String text = dateOfBirthField.controller.text;
    DateTime? date = stringToDate(text);

    Map<String, bool> conditions = {
      '잘못 입력하셨습니다': (today.year - (date?.year ?? 0)) > 99,
      '미래는 입력할 수 없습니다': today.isBefore(date ?? today),
      '오늘은 입력할 수 없습니다': isSameDay(today, date ?? today),
      '없는 날짜 입니다': date == null,
      '여덟 글자가 아닙니다': text.length != 8,
      '숫자만 입력해주세요': int.tryParse(text) == null,
      '생년월일을 입력해주세요': text == '',
    };

    conditions.forEach((message, condition) {
      if (condition) dateOfBirthField.hintText = message;
    });

    if (conditions.values.any((condition) => condition)) {
      invalid = true;
      dateOfBirthField.controller.clear();
      dateOfBirthField.invalid = true; update();
      await Future.delayed(const Duration(milliseconds: 500), () {
        dateOfBirthField.invalid = false; update();
      });
      await Future.delayed(const Duration(milliseconds: 500), () {
        dateOfBirthField.controller.text = text; update();
        dateOfBirthField.hintText = null;
      });
    }
  }

  void sexValidate() async {
    Field sexField = fields['sex']!;

    if (newcomer.sex == null) {
      invalid = true;
      sexField.invalid = true; update();
      await Future.delayed(const Duration(milliseconds: 500), () {
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
      case 2: break;
      case 3:
        initGoal(ActivityType.distance, 15);
        break;
      case 4: break;
      case 5:
        initGoal(ActivityType.height, 15);
        break;
      case 6:
        int goal = 0;
        for (var type in ActivityType.activeValues.sublist(1)) {
          int amount = newcomer.goals[type.name].toInt();
          if (type == ActivityType.distance) amount = distanceMinute;
          goal += convertToCalories(type, amount);
        }
        newcomer.goals[ActivityType.calorie.name] = goal;
        update();
        break;
      case 7:
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
