/* 첼린지 메인 페이지 프리젠터 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/class/challenge.dart';

/// class
class ChallengePresenter extends GetxController {
  static String asset = 'assets/json/data/challenges.json';
  static List<Challenge> challenges = [];
  static List<Challenge> get availableChallenges => challenges
      .where((challenge) => !challenge.locked).toList();

  static Future importFile() async {
    String string = await rootBundle.loadString(asset);
    List<dynamic> list = jsonDecode(string);
    challenges = list.map((json) => Challenge.fromJson(json)).toList();
  }

  static Challenge? getChallenge(String id) => challenges
      .firstWhereOrNull((challenge) => challenge.id == id);
}
