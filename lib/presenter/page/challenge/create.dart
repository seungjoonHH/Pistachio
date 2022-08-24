import 'package:pistachio/model/class/challenge.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/enum/enum.dart';

class ChallengeCreate extends GetxController {
  static void toChallengeCreate(Challenge challenge) {
    Get.toNamed('/challenge/create', arguments: challenge);
  }

  Difficulty difficulty = Difficulty.easy;

  void changeDifficulty(Difficulty diff) {
    difficulty = diff; update();
  }
}