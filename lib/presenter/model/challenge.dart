/* 첼린지 메인 페이지 프리젠터 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/class/challenge.dart';

/// class
class ChallengePresenter extends GetxController {
  static String asset = 'assets/json/data/challenges.json';

  /// static methods
  static void toChallengeMain() => Get.offAllNamed('/challenge/main');

  static List<Challenge> challenges = [];

  static Future importFile() async {
    String string = await rootBundle.loadString(asset);
    List<dynamic> list = jsonDecode(string);
    challenges = list.map((json) => Challenge.fromJson(json)).toList();
  }
}
