import 'package:get/get.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';

// 성비
const double sexRatio = .994;

/* 키 */
// 남자 평균 키 (cm)
// const double maleHeight = 172.5;
//
// // 여자 평균 키 (cm)
// const double femaleHeight = 159.6;
//
// // 평균 키 (cm)
// const double height = (
//   sexRatio * maleHeight + 100 * femaleHeight
// ) / (100 + sexRatio);


int get weight => Get.find<UserPresenter>().loggedUser.weight ?? 0;
int get height => Get.find<UserPresenter>().loggedUser.height ?? 0;

int convertAmount(ActivityType type, int amount) {
  switch (type) {
    case ActivityType.distance:
      Walking.velocity * .5 + Jogging.velocity * .3 + Running.velocity * .2;
      return (amount * Jogging.velocity).ceil();
    case ActivityType.weight: return (amount * weight).ceil();
    default: return amount;
  }
}

// 걷기
class Walking {
  static const double coefficient = .9;
  static const int velocity = 100;
  static int get calorie => (weight * coefficient).ceil();
}

// 조깅
class Jogging {
  static const double coefficient = 1.2;
  static const int velocity = 145;
  static int get calorie => (weight * coefficient).ceil();
}

// 달리기
class Running {
  static const double coefficient = 2.0;
  static const int velocity = 167;
  static int get calorie => (weight * coefficient).ceil();
}

// 계단오르기
class StairClimbing {
  static const double coefficient = 1.6;
  static int get calorie => (weight * coefficient).ceil();
}

// 근력운동
class MuscularExercise {
  static const double coefficient = 1.225;
  static int get calorie => (weight * coefficient).ceil();
}