/* 컬렉션 프리젠터 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/class/json/badge.dart';

// collections.json 파일 관련
class BadgePresenter extends GetxController {
  static String asset = 'assets/json/data/badges.json';
  static List<Badge> badges = [];

  static Future importFile() async {
    String string = await rootBundle.loadString(asset);
    List<dynamic> list = jsonDecode(string);
    badges = list.map((json) => Badge.fromJson(json)).toList();
  }

  static Badge? getBadge(String? id) => badges
      .firstWhereOrNull((collection) => collection.id == id);
}