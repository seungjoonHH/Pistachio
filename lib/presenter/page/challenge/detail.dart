import 'package:get/get.dart';
import 'package:pistachio/model/class/json/challenge.dart';

class ChallengeDetail {
  static void toChallengeDetail(Challenge challenge) {
    Get.toNamed('/challenge/detail', arguments: challenge);
  }
}