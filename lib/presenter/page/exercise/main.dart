import 'dart:async';

import 'package:pistachio/presenter/page/complete.dart';
import 'package:get/get.dart';

enum ExerciseState { unselected, ready, ongoing, pause, stop }

class ExerciseMain extends GetxController {
  int second = 3;
  int count = 0;

  Timer? exerciseTimer;
  int assetIndex = 0;

  ExerciseState state = ExerciseState.unselected;

  static int exerciseTime = 2;

  static List<String> assets = [
    'assets/image/exercise/squat_up.svg',
    'assets/image/exercise/squat_down.svg'
  ];

  static void toExerciseMain([ExerciseState? state]) {
    final exerciseMainPresenter = Get.find<ExerciseMain>();
    exerciseMainPresenter.stopExercise();
    exerciseMainPresenter.state = state ?? ExerciseState.unselected;
    Get.toNamed('/exercise/main');
  }

  static void toExerciseTypeSetting() {
    Get.toNamed('/exercise/setting/type');
  }

  static void toExerciseDetailSetting() {
    Get.toNamed('/exercise/setting/detail');
  }

  void decreaseSecond() { second--; update(); }
  Future startThreeSecondsTimer() async {
    state = ExerciseState.ready;
    second = 3; update();
    for (int i = 0; i < 3; i++) {
      await Future.delayed(const Duration(seconds: 1), decreaseSecond);
    }
    if (state == ExerciseState.ready) state = ExerciseState.ongoing;
    update();
  }

  void increaseCount(Timer timer) {
    if (timer.tick % (exerciseTime * 50) == 0) {
      assetIndex = (assetIndex + 1) % assets.length;
      if (timer.tick % (exerciseTime * 100) == 0) count++;
    }
    update();
  }

  Future startExercise() async {
    if (state == ExerciseState.stop) await startThreeSecondsTimer();
    if (state == ExerciseState.pause) { state = ExerciseState.ongoing; }
    exerciseTimer = Timer.periodic(
      const Duration(milliseconds: 10), increaseCount,
    );
    update();
  }

  void pauseExercise() {
    assetIndex = 0;
    exerciseTimer?.cancel();
    state = ExerciseState.pause;
    update();
  }

  void stopExercise() {
    assetIndex = 0;
    exerciseTimer?.cancel();
    state = ExerciseState.stop;
    second = 3; count = 0; update();
  }

  void finishExercise() => CompletePresenter.toComplete(.122, .533);
}