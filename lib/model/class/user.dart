/* 사용자 모델 구조 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/model/enum/enum.dart';

class PUser {
  /// attributes
  String? uid;
  String? name;
  String? nickname;
  int? weight;
  int? height;
  Sex? sex;
  Timestamp? _regDate;
  Timestamp? _dateOfBirth;
  String? collectionId;
  List<String> partyIds = [];
  List<Map<String, dynamic>> collectionIds = [];
  Map<String, dynamic> goals = {};
  Map<String, dynamic> records = {};

  /// accessors & mutators
  DateTime? get regDate => _regDate?.toDate();

  DateTime? get dateOfBirth => _dateOfBirth?.toDate();

  set regDate(DateTime? date) => _regDate = toTimestamp(date);

  set dateOfBirth(DateTime? date) => _dateOfBirth = toTimestamp(date);

  String? get dateOfBirthString => dateToString('yyyy-MM-dd', dateOfBirth);

  void setRecord(ActivityType type, DateTime date, int amount) {
    for (var record in records[type.name] ?? []) {
      if (record['date'] == toTimestamp(date)) {
        record['amount'] += amount; return;
      }
    }
    records[type.name].add({'date': toTimestamp(date), 'amount': amount});
  }

  int getTodayAmounts(ActivityType type) => getAmounts(type, today, tomorrow);
  int getThisMonthAmounts(ActivityType type) {
    DateTime firstDate = DateTime(today.year, today.month, 1);
    DateTime lastDate = DateTime(today.year, today.month + 1, 1)
        .subtract(const Duration(days: 1));

    return getAmounts(type, firstDate, lastDate);
  }
  int getAmounts(ActivityType activityType, [DateTime? startDate, DateTime? endDate]) {
    int result = 0;

    records.forEach((type, recordList) {
      if (activityType.name == type) {
        for (var record in recordList) {
          if (startDate != null && record['date'].toDate().isBefore(startDate)) continue;
          if (endDate != null && record['date'].toDate().isAfter(endDate)) continue;
          result += record['amount'] as int;
        }
      }
    });
    return result;
  }

  /// constructors
  PUser() {
    weight = 60;
    height = 170;
    for (var type in ActivityType.values) {
      goals[type.name] = null;
      records[type.name] = [];
    }
  }

  PUser.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  /// methods
  void fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    nickname = json['nickname'];
    weight = json['weight'].toInt();
    height = json['height'].toInt();
    sex = toSex(json['sex']);
    _regDate = json['regDate'];
    _dateOfBirth = json['dateOfBirth'];
    collectionId = json['collectionId'];
    partyIds = (json['partyIds'] ?? []).cast<String>();
    collectionIds = (json['collectionIds'] ?? []).cast<Map<String, dynamic>>();
    goals = json['goals'];
    records = json['records'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['uid'] = uid;
    json['name'] = name;
    json['nickname'] = nickname;
    json['weight'] = weight;
    json['height'] = height;
    json['sex'] = sex?.name;
    json['regDate'] = _regDate;
    json['dateOfBirth'] = _dateOfBirth;
    json['collectionId'] = collectionId;
    json['partyIds'] = partyIds;
    json['collectionIds'] = collectionIds;
    json['goals'] = goals;
    json['records'] = records;
    return json;
  }
}
