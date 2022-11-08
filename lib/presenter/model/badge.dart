/* 뱃지 프리젠터 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/model/class/json/badge.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/model/user.dart';

/// class
// 뱃지 [badges.json] 파일 관련
class BadgePresenter extends GetxController {
  /// static variables
  static String asset = 'assets/json/data/badges.json';
  static List<Badge> badges = [];

  /// static methods
  // json 파일 불러오기
  static Future importFile() async {
    String string = await rootBundle.loadString(asset);
    List<dynamic> list = jsonDecode(string);
    badges = list.map((json) => Badge.fromJson(json)).toList();
  }

  // 뱃지 아이디에 해당하는 뱃지 반환
  static Badge? getBadge(String? id) => badges
      .firstWhereOrNull((badge) => badge.id == id);

  static Badge? getThisMonthQuestBadge(ActivityType type) {
    if (!type.active) return null;
    return getBadge('1040${type.index}${
      (today.month - 1).toString().padLeft(2, '0')}'
    );
  }

  // 일일 활동 완료 뱃지 획득
  static void awardDailyActivityCompleteBadge() async {
    final userP = Get.find<UserPresenter>();
    Badge badge = BadgePresenter.getBadge('1000001')!;

    for (Collection collection in userP.loggedUser.collections) {
      if (collection.badgeId == badge.id) {
        if (collection.dates.map((date) => ignoreTime(date!)).contains(today)) return;
        GlobalPresenter.badgeAwarded(badge);
        collection.addDate(now);
        return;
      }
    }
    GlobalPresenter.badgeAwarded(badge, true);
    userP.awardBadge(badge);
  }
}