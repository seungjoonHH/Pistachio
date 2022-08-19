import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';

// 성별 { 남성, 여성 }
enum Sex {
  male, female;
String get kr => ['남성', '여성'][index];
}

// 문자열을 성별 enum 으로 전환 ('male' => Sex.male)
Sex? toSex(String? string) => Sex.values
    .firstWhereOrNull((sex) => sex.name == string);

enum ActivityType {
  distance, height, weight, calorie;
String get kr => ['거리', '높이', '무게', '칼로리'][index];
String get unit => ['보', '층', '회', 'kcal'][index];
String get exercise => ['유산소', '계단오르기', '근력운동', '음식'][index];
String get prefix => ['이동한', '오른', '들은', '감량한'][index];
Color get color => [
  PTheme.brickRed, PTheme.crystalBlue,
  PTheme.dessertGold, PTheme.parkGreen
][index];
String get asset => [
  'running.svg', 'stairs.svg', 'dumbbell.svg', 'lightning.svg',
][index];
}

// 문자열을 활동 형태 enum 으로 전환 ('distance' => ActivityType.distance)
ActivityType? toActivityType(String? string) => ActivityType.values
    .firstWhereOrNull((type) => type.name == string);

enum Difficulty {
  hard, normal, easy;
String get kr => ['상', '중', '하'][index];
}

enum DialogType { none, mono, bi }

// 로그인 형식 { 구글, ... }
enum LoginType { google, apple }