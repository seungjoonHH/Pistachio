import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/number.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/class/json/badge.dart';
import 'package:pistachio/model/class/json/challenge.dart';
import 'package:pistachio/model/enum/difficulty.dart';
import 'package:pistachio/presenter/model/badge.dart';
import 'package:pistachio/presenter/model/challenge.dart';

class Party {
  /// attributes
  // 일반 변수
  String? id;
  String? challengeId;
  Difficulty difficulty = Difficulty.easy;
  Map<String, dynamic> records = {};
  String? leaderUid;
  bool complete = false;
  Timestamp? _startDate;
  Timestamp? _endDate;

  // 의존 변수
  PUser? leader; // leaderUid 에 의존
  List<PUser> members = []; // records 에 의존

  /// accessors & mutators
  DateTime? get startDate => _startDate?.toDate();
  DateTime? get endDate => _endDate?.toDate();
  set startDate(DateTime? date) => _startDate = toTimestamp(date);
  set endDate(DateTime? date) => _endDate = toTimestamp(date);

  Challenge? get challenge => ChallengePresenter.getChallenge(challengeId);
  List<String> get memberUids => records.keys.toList();

  bool get over => today.isAfter(endDate!);
  int get overDays => today.difference(endDate!).inDays;
  int get remainDays => -overDays;

  List<double> get recordValues => records.values
      .map<double>((e) => e.toDouble()).toList();
  double get recordSum => sum(recordValues).toDouble();
  double get recordAverage => average(recordValues).toDouble();

  bool get satisfy => recordSum >= level['goal'];

  String get dDay => overDays > 0
      ? '종료' : overDays == 0
      ? 'D-day' : 'D${over ? '+' : ''}$overDays';
  String get periodString =>
      '${dateToString('M/d', startDate)} ~ ${dateToString('M/d', endDate)}';

  Map<String, dynamic> get level => challenge!.getLevel(difficulty)!;

  List<MapEntry<String, dynamic>> get ranks {
    List<MapEntry<String, dynamic>> ranks = records.entries.toList();
    ranks.sort((a, b) => b.value - a.value);
    return ranks;
  }

  int getRank(String uid) => ranks.indexWhere((rank) => rank.key == uid) + 1;
  PUser getMember(String uid) => members.firstWhere((member) => member.uid == uid);
  PUser getMemberByRank(int rank) => getMember(ranks[rank - 1].key);
  PUser get winner => getMemberByRank(1);

  PBadge get badge => BadgePresenter.getBadge(level['collection'])!;

  /// constructors
  Party();

  Party.fromJson(Map<String, dynamic> json) {
    fromJson(json);
    if (_startDate == null) startDate = today;
    if (_endDate == null) endDate = today.add(Duration(days: challenge!.period!));
  }

  /// methods
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    challengeId = json['challengeId'];
    difficulty = Difficulty.toEnum(json['difficulty'])!;
    records = json['records'] ?? <String, dynamic>{};
    leaderUid = json['leaderUid'];
    complete = json['complete'];
    startDate = json['startDate']?.toDate();
    endDate = json['endDate']?.toDate();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['challengeId'] = challengeId;
    json['difficulty'] = difficulty.name;
    json['records'] = records;
    json['leaderUid'] = leaderUid;
    json['complete'] = complete;
    json['startDate'] = startDate;
    json['endDate'] = endDate;
    return json;
  }

}