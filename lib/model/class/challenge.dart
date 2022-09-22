import 'package:flutter/cupertino.dart';
import 'package:pistachio/model/class/badge.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/collection.dart';

class Challenge {
  /// static variables
  static String imageAsset = 'assets/image/challenge/';

  /// static methods
  static Map<String, dynamic> idToImageUrls(String id) => {
    'default': '${imageAsset}default/$id.png',
    'complete': '${imageAsset}complete/$id.png',
    'focus': '${imageAsset}focus/$id.png',
  };

  /// attributes
  bool locked = false;
  String? id;
  String? title;
  ActivityType? type;
  String? word;
  Color? theme;
  int? period;
  Map<String, dynamic> imageUrls = {};
  Map<String, dynamic> descriptions = {};
  Map<String, dynamic> levels = {};

  Map<Difficulty, Badge> badges = {};

  String? get titleOneLine => title?.replaceAll('\n', ' ');

  /// constructors
  Challenge();

  Challenge.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  /// methods
  void fromJson(Map<String, dynamic> json) {
    locked = json['locked'];
    id = json['id'];
    title = json['title'];
    imageUrls = idToImageUrls(id!);
    type = toActivityType(json['type']);
    word = json['word'];
    levels = json['levels'];
    period = json['period'];
    descriptions = json['descriptions'];
    levels.forEach((string, level) {
      String id = level['collection'];
      badges[toDifficulty(string)!] = BadgePresenter.getBadge(id)!;
    });
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['title'] = title;
    json['type'] = type?.name;
    json['word'] = word;
    json['levels'] = levels;
    json['period'] = period;
    json['descriptions'] = descriptions;
    return json;
  }
}