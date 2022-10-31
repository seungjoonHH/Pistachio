/* 첼린지 메인 페이지 프리젠터 */
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/class/json/challenge.dart';

/// class
// 챌린지 [challenges.json] 파일 관련
class ChallengePresenter extends GetxController {
  static String asset = 'assets/json/data/challenges.json';
  static List<Challenge> challenges = [];
  static List<Challenge> get availableChallenges => challenges
      .where((challenge) => !challenge.locked).toList();

  // 챌린지 json 파일 가져오기
  static Future importFile() async {
    String string = await rootBundle.loadString(asset);
    List<dynamic> list = jsonDecode(string);
    challenges = list.map((json) => Challenge.fromJson(json)).toList();
  }

  // 해당 아이디의 챌린지 반환
  static Challenge? getChallenge(String id) => challenges
      .firstWhereOrNull((challenge) => challenge.id == id);
}
