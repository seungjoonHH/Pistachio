import 'package:pistachio/model/class/challenge.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/enum/enum.dart';

class ChallengeDifficulty extends GetxController {
  static void toChallengeDifficulty(Challenge challenge) {
    Get.toNamed('/challenge/difficulty', arguments: challenge);
  }

  Difficulty difficulty = Difficulty.easy;

  void changeDifficulty(Difficulty diff) {
    difficulty = diff; update();
  }
}