import 'package:flutter/cupertino.dart';
import 'package:pistachio/model/class/collection.dart';
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
  String? id;
  String? title;
  ActivityType? type;
  String? word;
  Color? theme;
  Map<String, dynamic> imageUrls = {};
  Map<String, dynamic> descriptions = {};
  Map<String, dynamic> levels = {};

  Map<Difficulty, Collection> collections = {};

  /// constructors
  Challenge();

  Challenge.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  /// methods
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrls = idToImageUrls(id!);
    type = toActivityType(json['type']);
    word = json['word'];
    levels = json['levels'];
    descriptions = json['descriptions'];
    levels.forEach((string, level) {
      String id = level['collection'];
      collections[toDifficulty(string)!] = CollectionPresenter.getCollection(id)!;
    });
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['title'] = title;
    json['type'] = type?.name;
    json['word'] = word;
    json['levels'] = levels;
    json['descriptions'] = descriptions;
    return json;
  }
}