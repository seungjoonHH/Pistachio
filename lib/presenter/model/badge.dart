/* 뱃지 프리젠터 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/class/json/badge.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/firebase/auth/auth.dart';
import 'package:pistachio/presenter/model/party.dart';
import 'package:pistachio/presenter/model/user.dart';

/// class
// 뱃지 [badges.json] 파일 관련
class BadgePresenter extends GetxController {
  /// static variables
  static String asset = 'assets/json/data/badges.json';
  static List<PBadge> badges = [];

  /// static methods
  // json 파일 불러오기
  static Future importFile() async {
    String string = await rootBundle.loadString(asset);
    List<dynamic> list = jsonDecode(string);
    badges = list.map((json) => PBadge.fromJson(json)).toList();
  }

  static List<PBadge> get availableBadges {
    List<PBadge> badgeList = [...badges];
    badgeList.removeWhere((badge) => !badge.activate!);
    return badgeList;
  }

  static List<PBadge> get notAcquiredBadges {
    PUser user = Get.find<UserPresenter>().loggedUser;
    List<PBadge> badgeList = [...availableBadges];
    badgeList.removeWhere((badge) => user.hasCollection(badge.id!));
    return badgeList;
  }

  // 뱃지 아이디에 해당하는 뱃지 반환
  static PBadge? getBadge(String? id) => badges
      .firstWhereOrNull((badge) => badge.id == id);

  static PBadge? getThisMonthQuestBadge(ActivityType type) {
    if (!type.active) return null;
    return getBadge('1040${type.index}${
      (today.month - 1).toString().padLeft(2, '0')}'
    );
  }

  // 일일 활동 완료 뱃지 획득
  static void awardDailyActivityCompleteBadge() async {
    final userP = Get.find<UserPresenter>();
    userP.awardBadge(BadgePresenter.getBadge('1000001')!, true, true);
  }

  static Future synchronizeBadges() async {
    final inAppReview = InAppReview.instance;
    final userP = Get.find<UserPresenter>();
    PUser user = userP.loggedUser;

    // 운영자 뱃지 지급
    if (AuthPresenter.developerUids.contains(user.uid)) {
      userP.awardBadge(BadgePresenter.getBadge('1999999')!, true);
    }

    // 작심삼일, 완벽한주 뱃지 지급
    int consecutive3 = user.countCompletedDaysInARow(3);
    int consecutive7 = user.countCompletedDaysInARow(7);
    int count3 = user.getCollectionsById('1000003')?.dates.length ?? 0;
    int count7 = user.getCollectionsById('1000004')?.dates.length ?? 0;

    for (int i = 0; i < consecutive3 - count3; i++) {
      userP.awardBadge(BadgePresenter.getBadge('1000003')!);
    }
    for (int i = 0; i < consecutive7 - count7; i++) {
      userP.awardBadge(BadgePresenter.getBadge('1000004')!);
      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
      }
    }

    for (String id in user.partyIds) {
      Party? party = await PartyPresenter.loadParty(id);
      if (party == null) break;
      if (!party.complete) continue;
      userP.awardBadge(party.badge, true);
    }
  }
}