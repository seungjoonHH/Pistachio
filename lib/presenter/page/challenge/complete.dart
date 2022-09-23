import 'package:get/get.dart';
import 'package:pistachio/model/class/json/challenge.dart';

class ChallengeComplete {
  static void toChallengeComplete(Challenge challenge) {
    Get.toNamed('/challenge/complete', arguments: challenge);
  }
}