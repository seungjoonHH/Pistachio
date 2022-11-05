import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../../model/class/database/user.dart';
import '../../model/enum/enum.dart';
import '../../view/page/editGoal/widget.dart';
import '../model/record.dart';
import '../model/user.dart';
import 'home.dart';

class Field {
  bool invalid = false;
  dynamic controller;

  Field([this.controller]);
}

/// class
class EditGoalPresenter extends GetxController {
  PUser user = PUser();
  int pageIndex = 0;
  bool keyboardVisible = false;
  List<bool> imageExistence = [
    false,
    false,
    false,
    true,
    true,
    true,
    true,
    true
  ];
  bool imageVisualize = false;

  static const Duration shakeDuration = Duration(milliseconds: 500);

  static Curve transitionCurve = Curves.easeInOut;
  static const Duration transitionDuration = Duration(milliseconds: 350);

  /// static variables
  static final carouselCont = CarouselController();

  static void toEditGoal() {
    final editGoalP = Get.find<EditGoalPresenter>();
    Get.toNamed('/editGoal');
    editGoalP.init();
  }

  /// static methods
  // 컨트롤러를 모두 초기화
  void init() {
    final userP = Get.find<UserPresenter>();
    user = userP.loggedUser;
    pageIndex = 0;
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

  void setKeyboardVisible(bool value) {
    keyboardVisible = value;
    update();
  }

  void initGoal(Record record) async {
    user.goals[record.type!.name] = 0;
    update();
    await Future.delayed(const Duration(milliseconds: 500), () {
      user.setGoal(record.type!, record);
      update();
    });
  }

  void submitted() async {
    final userP = Get.find<UserPresenter>();
    userP.update();
    userP.save();
    await HomePresenter.toHome();
    init();
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
        break;
      case 1:
        initGoal(Record.init(
          ActivityType.distance,
          90,
          DistanceUnit.minute,
        ));
        break;
      case 2:
        break;
      case 3:
        initGoal(Record.init(ActivityType.height, 20));
        break;
      case 4:
        Record calorie = CalorieRecord(amount: 0);
        DistanceRecord distance =
            user.getGoal(ActivityType.distance) as DistanceRecord;
        HeightRecord height = user.getGoal(ActivityType.height) as HeightRecord;
        calorie.amount +=
            CalorieRecord.from(ActivityType.distance, distance.minute);
        calorie.amount +=
            CalorieRecord.from(ActivityType.height, height.amount);

        user.setGoal(ActivityType.calorie, calorie);
        update();
        break;
      case 5:
        submitted();
        return;
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
      HomePresenter.toHome();
    }

    carouselCont.previousPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    slideBack();
    pageIndexDecrease();
  }
}
