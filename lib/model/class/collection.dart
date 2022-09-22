import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/model/class/badge.dart';
import 'package:pistachio/presenter/model/collection.dart';

class Collection {
  List<Timestamp> dateList = [];
  String? badgeId;

  Badge? badge;

  set dates(List<DateTime?> dates) => dates.map((date) => toTimestamp(date)).toList();
  List<DateTime?> get dates => dateList.map((date) => date.toDate()).toList();

  Collection();

  Collection.fromJson(Map<String, dynamic> json) {
   fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    dateList = json['dates'].cast<Timestamp>();
    badgeId = json['badgeId'];
    badge = BadgePresenter.getBadge(badgeId!);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['dates'] = dateList;
    json['badgeId'] = badgeId;
    return json;
  }
}