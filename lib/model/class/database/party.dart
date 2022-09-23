import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/class/json/challenge.dart';
import 'package:pistachio/model/enum/enum.dart';

class Party {
  /// attributes
  // 일반 변수
  String? id;
  String? challengeId;
  Difficulty difficulty = Difficulty.easy;
  Map<String, dynamic> records = {};
  String? leaderUid;
  Timestamp? _startDate;
  Timestamp? _endDate;

  // 의존 변수
  PUser? leader; // leaderUid 에 의존
  Challenge? challenge; // challengeId 에 의존
  List<PUser> members = []; // records 에 의존

  /// accessors & mutators
  DateTime? get startDate => _startDate?.toDate();
  DateTime? get endDate => _endDate?.toDate();
  set startDate(DateTime? date) => _startDate = toTimestamp(date);
  set endDate(DateTime? date) => _endDate = toTimestamp(date);

  /// constructors
  Party();

  Party.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  /// methods
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    challengeId = json['challengeId'];
    difficulty = Difficulty.toEnum(json['difficulty'])!;
    records = json['records'] ?? <String, dynamic>{};
    leaderUid = json['leaderUid'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['challengeId'] = challengeId;
    json['difficulty'] = difficulty.name;
    json['records'] = records;
    json['leaderUid'] = leaderUid;
    return json;
  }

}