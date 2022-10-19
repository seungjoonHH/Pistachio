import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';

// 성별 { 남성, 여성 }
enum Sex {
  male, female;
  String get kr => ['남성', '여성'][index];

  // 문자열을 enum 으로 전환
  static Sex? toEnum(String? string) =>
      Sex.values.firstWhereOrNull((sex) => sex.name == string);
}

enum Difficulty {
  easy, normal, hard;
  String get kr => ['쉬움', '보통', '어려움'][index];

  // 문자열을 enum 으로 전환
  static Difficulty? toEnum(String? string) =>
      Difficulty.values.firstWhereOrNull((diff) => diff.name == string);
}

enum ActivityType {
  // distance, height, weight, calorie;
  //
  // String get kr => ['거리', '높이', '무게', '칼로리'][index];
  // String get unit => ['보', '층', '회', 'kcal'][index];
  // String get unitAlt => ['보', '층', 'kg', 'kcal'][index];
  // String get prefix => ['이동한', '오른', '들은', '감량한'][index];
  // String get verb => ['걸으세요', '오르세요', '들으세요', '감량하세요'][index];
  // Color get color => [PTheme.colorB, PTheme.colorD, PTheme.colorC, PTheme.colorA][index];
  // String get asset => ['running.svg', 'stairs.svg', 'dumbbell.svg', 'lightning.svg'][index];

  calorie, distance, height, weight;

  String get kr => ['칼로리', '거리', '높이', '무게'][index];
  String get unit => ['kcal', '보', '층', '회'][index];
  String get unitAlt => ['kcal', '보', '층', 'kg'][index];
  String get prefix => ['감량한', '이동한', '오른', '들은'][index];
  String get verb => ['감량하세요', '걸으세요', '오르세요', '들으세요'][index];
  Color get color => [PTheme.colorA, PTheme.colorB, PTheme.colorD, PTheme.colorC][index];
  String get asset => ['lightning.svg', 'running.svg', 'stairs.svg', 'dumbbell.svg'][index];
  bool get active => activeValues.contains(this);

  // 문자열을 enum 으로 전환
  static ActivityType? toEnum(String? string) =>
      ActivityType.values.firstWhereOrNull((type) => type.name == string);

  static List<ActivityType> get activeValues => [calorie, distance, height];

}

// 팝업창 형식 { 버튼 없음, 버튼 1개, 버튼 2개 }
enum DialogType { none, mono, bi }

// 로그인 형식 { 구글, 애플, ... }
enum LoginType { google, apple }

// 외곽선 형식
enum BorderType { all, horizontal, vertical, left, top, right, bottom, none }

enum DistanceUnit { minute, step, kilometer }

enum PageMode { view, edit }