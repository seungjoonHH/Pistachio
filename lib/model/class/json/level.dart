class Level {
  /// attributes
  String? id;
  String? title;
  int? amount;
  String? imageUrl;

  /// constructors
  Level();

  Level.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  /// methods
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    imageUrl = idToImageUrl(id!);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['title'] = title;
    json['amount'] = amount;
    return json;
  }

  /// static variables
  static String asset = 'assets/image/level/';

  /// static methods
  static String idToImageUrl(String id) => '$asset$id.svg';
}