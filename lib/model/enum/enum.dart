import 'package:get/get.dart';

// 성별 { 남성, 여성 }
enum Sex {
  male, female;
String get kr => ['남성', '여성'][index];
}

// 문자열을 성별 enum 으로 전환 ('male' => Sex.male)
Sex? toSex(String? string) => Sex.values
    .firstWhereOrNull((sex) => sex.name == string);

enum ExerciseType {
  distance, height, weight;
String get kr => ['거리', '높이', '무게'][index];
}

// 문자열을 운동 타입 enum 으로 전환 ('height' => ExerciseType.height)
ExerciseType? toType(String? string) => ExerciseType.values
    .firstWhereOrNull((type) => type.name == string);


enum Level {
  hard, normal, easy;
String get kr => ['상', '중', '하'][index];
}

enum DialogType { none, mono, bi }