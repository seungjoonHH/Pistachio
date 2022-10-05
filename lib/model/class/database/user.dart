/* 사용자 모델 구조 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/model/enum/enum.dart';

class PUser {
  /// attributes
  // 일반 변수
  String? uid;
  String? name;
  String? nickname;
  String? email;
  int? weight;
  int? height;
  Sex? sex;
  Timestamp? _regDate;
  Timestamp? _dateOfBirth;
  String? collectionId;
  List<String> partyIds = [];

  // 복합 변수
  List<Collection> collections = [];
  Map<String, dynamic> goals = {};
  Map<String, dynamic> records = {};

  // 의존 변수
  Map<String, Party> parties = {}; // partyIds 변수에 의존

  /// accessors & mutators
  DateTime? get regDate => _regDate?.toDate();
  DateTime? get dateOfBirth => _dateOfBirth?.toDate();

  String? get dateOfBirthString => dateToString('yyyy-MM-dd', dateOfBirth);

  set regDate(DateTime? date) => _regDate = toTimestamp(date);
  set dateOfBirth(DateTime? date) => _dateOfBirth = toTimestamp(date);

  /// constructors
  PUser() {
    weight = defaultWeight;
    height = defaultHeight;
    for (var type in ActivityType.activeValues) {
      goals[type.name] = 0;
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
    email = json['email'];
    weight = json['weight'].toInt();
    height = json['height'].toInt();
    sex = Sex.toEnum(json['sex']);
    _regDate = json['regDate'];
    _dateOfBirth = json['dateOfBirth'];
    collectionId = json['collectionId'];
    partyIds = (json['partyIds'] ?? []).cast<String>();
    collections = toCollections((json['collections'] ?? []).cast<Map<String, dynamic>>());
    goals = json['goals'];
    records = json['records'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['uid'] = uid;
    json['name'] = name;
    json['nickname'] = nickname;
    json['email'] = email;
    json['weight'] = weight;
    json['height'] = height;
    json['sex'] = sex?.name;
    json['regDate'] = _regDate;
    json['dateOfBirth'] = _dateOfBirth;
    json['collectionId'] = collectionId;
    json['partyIds'] = partyIds;
    json['collections'] = collectionsToJsonList(collections);
    json['goals'] = goals;
    json['records'] = records;
    return json;
  }

  /// methods
  void addRecord(ActivityType type, DateTime date, int amount) {
    for (var record in records[type.name] ?? []) {
      if (record['date'] == toTimestamp(date)) {
        record['amount'] += amount;
        return;
      }
    }
    records[type.name].add({'date': toTimestamp(date), 'amount': amount});
  }

  void setRecord(ActivityType type, DateTime date, int amount) {
    for (var record in records[type.name] ?? []) {
      if (record['date'] == toTimestamp(date)) {
        record['amount'] = amount;
        return;
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

  int getAmounts(
    ActivityType activityType, [
    DateTime? startDate,
    DateTime? endDate,
  ]) {
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

  /// static variables
  static int defaultWeight = 60;
  static int defaultHeight = 170;

  /// static methods
  static List<Collection> toCollections(List<Map<String, dynamic>> jsonList) {
    List<Collection> collections = [];
    for (var json in jsonList) { collections.add(Collection.fromJson(json)); }
    return collections;
  }

  static List<Map<String, dynamic>> collectionsToJsonList(List<Collection> collections) {
    List<Map<String, dynamic>> jsonList = [];
    for (Collection collection in collections) { jsonList.add(collection.toJson()); }
    return jsonList;
  }
}
