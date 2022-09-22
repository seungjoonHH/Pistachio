/* 뱃지 모델 구조 */
class Badge {
  static const asset = 'assets/image/badge/';

  /// attributes
  String? id;
  String? title;
  String? imageUrl;
  String? description;

  /// constructors
  Badge();

  Badge.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  /// methods
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = '$asset$id.png';
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['title'] = title;
    json['description'] = description;
    return json;
  }
}