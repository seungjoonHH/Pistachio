import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/model/class/user.dart';
import 'package:pistachio/model/enum/enum.dart';

class Party {
  /// attributes
  String? id;
  String? challengeId;
  Difficulty difficulty = Difficulty.easy;
  Map<String, dynamic> records = {};
  String? leaderUid;

  PUser? leader;
  Challenge? challenge;
  List<PUser> members = [];

  /// constructors
  Party();

  Party.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  /// methods
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    challengeId = json['challengeId'];
    difficulty = toDifficulty(json['difficulty'])!;
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