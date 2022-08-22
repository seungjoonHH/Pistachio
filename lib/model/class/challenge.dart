import 'package:flutter/cupertino.dart';
import 'package:pistachio/model/enum/enum.dart';

class Challenge {
  /// static variables
  static String defaultAsset = 'assets/image/challenge/default/';
  static String completeAsset = 'assets/image/challenge/complete/';

  /// static methods
  static Map<String, dynamic> idToImageUrls(String id) => {
    'default': '$defaultAsset$id.png',
    'complete': '$completeAsset$id.png',
  };

  /// attributes
  String? id;
  String? title;
  String? collectionId;
  ActivityType? type;
  Color? theme;
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
    type = toActivityType(json['type']);
    levels = json['levels'];
    descriptions = json['descriptions'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['title'] = title;
    json['collectionId'] = collectionId;
    json['type'] = type?.name;
    json['levels'] = levels;
    json['descriptions'] = descriptions;
    return json;
  }
}