/* 단계 프리젠터 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/class/json/level.dart';
import 'package:pistachio/model/enum/enum.dart';

// level/*.json 파일 관련
class LevelPresenter extends GetxController {
  static String asset = 'assets/json/data/level/';
  static Map<ActivityType, List<Level>> levels = {};

  static Future importFile(ActivityType type) async {
    String string = await rootBundle.loadString('$asset${type.name}.json');
    List<dynamic> list = jsonDecode(string);
    levels[type] = list.map((json) => Level.fromJson(json)).toList();
  }

  static Map<String, dynamic> getTier(ActivityType type, int amount) {
    Map<String, dynamic> result = {};

    List<Level> levelList = levels[type] ?? [];

    for (int i = 0; i < levelList.length - 1; i++) {
      int current = levelList[i].amount!;
      int next = levelList[i + 1].amount!;

      if (amount >= current && amount < next) {
        result['current'] = levelList[i].title;
        result['next'] = levelList[i + 1].title;
        result['percent'] = (amount - current) / (next - current);
      }
    }

    return result;
  }
}