/* 운동 프리젠터 */

import 'dart:convert';

import 'package:pistachio/model/class/exercise.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// exercises.json 파일 관련
class ExercisePresenter extends GetxController {
  static String asset = 'assets/json/data/exercises.json';
  List<Exercise> exercises = [];

  Future importFile() async {
    String string = await rootBundle.loadString(asset);
    List<dynamic> list = jsonDecode(string);
    exercises = list.map((json) => Exercise.fromJson(json)).toList();
  }

  // Future exportFile() async {
  //   List<dynamic> list = exercises.map((ex) => ex.toJson()).toList();
  //   File('/Users/hyeonseungjoon/Desktop/fitween_backup/Fitween/$asset').writeAsString(jsonEncode(list));
  // }
}