import 'package:pistachio/model/class/user.dart';
import 'package:pistachio/model/enum/enum.dart';

class Party {
  /// attributes
  String? id;
  String? challengeId;
  Difficulty difficulty = Difficulty.easy;
  Map<String, dynamic> goals = {};
  List<String> memberUids = [];

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
    difficulty = json['difficulty'];
    goals = json['goals'];
    memberUids = json['memberUids'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['challengeId'] = challengeId;
    json['difficulty'] = difficulty;
    json['goals'] = goals;
    json['memberUids'] = memberUids;
    return json;
  }

}