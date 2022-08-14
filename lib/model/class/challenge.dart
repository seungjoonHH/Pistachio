import 'package:flutter/cupertino.dart';
import 'package:pistachio/model/enum/enum.dart';

class Challenge {
  /// static variables
  static String defaultAsset = 'assets/image/collection/default/';
  static String completeAsset = 'assets/image/collection/complete/';

  /// static methods
  static Map<String, dynamic> idToImageUrls(String id) => {
    'default': '$defaultAsset$id.svg',
    'complete': '$completeAsset$id.svg',
  };

  static Map<String, dynamic> themeAsColor(Map<String, dynamic> json) {
    Map<String, dynamic> theme = {};
    json.forEach((key, value) => theme[key] = Color(value));
    return theme;
  }

  static Map<String, dynamic> themeAsInt(Map<String, dynamic> json) {
    Map<String, dynamic> theme = {};
    json.forEach((key, value) => theme[key] = value.value);
    return theme;
  }

  /// attributes
  String? id;
  String? title;
  String? collectionId;
  ExerciseType? type;
  Map<String, dynamic> theme = {};
  Map<String, dynamic> imageUrls = {};
  Map<String, dynamic> descriptions = {};
  Map<String, dynamic> levels = {};

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
    collectionId = json['collectionId'];
    type = toType(json['type']);
    theme = themeAsColor(json['theme']);
    levels = json['levels'];
    descriptions = json['descriptions'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['title'] = title;
    json['collectionId'] = collectionId;
    json['type'] = type?.name;
    json['theme'] = themeAsInt(theme);
    json['levels'] = levels;
    json['descriptions'] = descriptions;
    return json;
  }
}