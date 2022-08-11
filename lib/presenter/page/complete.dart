import 'package:get/get.dart';
import 'dart:math' as math;

class CompletePresenter extends GetxController {
  double before = .60;
  late double after;

  double before2 = .50;
  late double after2;

  bool levelUpState = false;
  int assetIndex = 0;

  List<String> assets = [
    'assets/image/object/moai_stone.svg',
    'assets/image/object/elephant.svg',
  ];
  List<String> titles = ['모아이 석상', '코끼리'];

  static void toComplete(double degree, [double? degree2]) {
    final completePresenter = Get.find<CompletePresenter>();
    Get.toNamed('/exercise/complete');
    completePresenter.initPercent();
    completePresenter.increasePercent(degree, degree2);
  }

  void initPercent() {
    assetIndex = 0;
    before = .60; after = before;
    before2 = .50; after2 = before2;
    update();
  }
  void increasePercent(double degree, [double? degree2]) async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      after += degree;
      after2 = math.min(before + (degree2 ?? 0.0), 1.0);
      update();
    });
    await Future.delayed(const Duration(milliseconds: 1000), () {
      if (after2 == 1.0) levelUp();
    });
  }

  void levelUp() async {
    levelUpState = true; update();
    await Future.delayed(const Duration(milliseconds: 1000), () {
      levelUpState = false;
    });
    await Future.delayed(const Duration(milliseconds: 1000), () {
      assetIndex = 1;
      before2 = .0;
      after2 = .12;
      update();
    });
  }
}