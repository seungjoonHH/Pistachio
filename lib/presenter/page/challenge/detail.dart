import 'package:pistachio/model/class/challenge.dart';
import 'package:get/get.dart';

class ChallengeDetail {
  static void toChallengeDetail(Challenge challenge) {
    Get.toNamed('/challenge/detail', arguments: challenge);
  }
}