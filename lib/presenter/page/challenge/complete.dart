import 'package:get/get.dart';
import 'package:pistachio/model/class/json/challenge.dart';

/// class
class ChallengeComplete {
  /// static methods
  // 챌린지 완료 페이지로 이동
  static void toChallengeComplete(Challenge challenge) {
    Get.toNamed('/challenge/complete', arguments: challenge);
  }
}