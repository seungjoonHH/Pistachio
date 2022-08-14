/* 운동 모델 구조 */
class Exercise {
  /// attributes
  int? index;
  String? name;
  String? imageUrl;
  String? description;

  /// constructors
  Exercise();

  Exercise.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  /// methods
  void fromJson(Map<String, dynamic> json) {
    index = json['index'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['index'] = index;
    json['name'] = name;
    json['imageUrl'] = imageUrl;
    json['description'] = description;
    return json;
  }
}