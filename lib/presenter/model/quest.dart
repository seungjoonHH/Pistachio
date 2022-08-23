import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/enum/enum.dart';

// quests.json 파일 관련
class QuestPresenter extends GetxController {
  static String asset = 'assets/json/data/quests.json';
  static Map<ActivityType, int> quests = {};

  static Future importFile() async {
    String string = await rootBundle.loadString(asset);
    Map<String, dynamic> list = jsonDecode(string);
    list.forEach((type, amount) {
      quests[toActivityType(type)!] = amount.toInt();
    });
  }
}