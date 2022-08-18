import 'package:pistachio/model/class/challenge.dart';
import 'package:get/get.dart';

class ChallengeDifficulty {
  static void toChallengeDifficulty(Challenge challenge) {
    Get.toNamed('/challenge/difficulty', arguments: challenge);
  }
}