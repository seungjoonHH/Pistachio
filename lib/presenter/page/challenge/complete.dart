import 'package:pistachio/model/class/challenge.dart';
import 'package:get/get.dart';

class ChallengeComplete {
  static void toChallengeComplete(Challenge challenge) {
    Get.toNamed('/challenge/complete', arguments: challenge);
  }
}