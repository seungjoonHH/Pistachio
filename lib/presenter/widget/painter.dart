import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/class/workout/edge.dart';
import 'package:pistachio/model/class/workout/limb.dart';
import 'package:pistachio/model/enum/part.dart';
import 'package:pistachio/model/enum/workout.dart';

class PainterPresenter extends GetxController {
  static Size canvasSize = Size(
    MediaQuery.of(Get.context!).size.width,
    MediaQuery.of(Get.context!).size.height * .7,
  );

  static List<Edge> edges = [
    Edge.index( 0,  1), // nose to left_eye
    Edge.index( 0,  2), // nose to right_eye
    Edge.index( 1,  3), // left_eye to left_ear
    Edge.index( 2,  4), // right_eye to right_ear
    Edge.index( 0,  5), // nose to left_shoulder
    Edge.index( 0,  6), // nose to right_shoulder
    Edge.index( 5,  7), // left_shoulder to left_elbow
    Edge.index( 7,  9), // left_elbow to left_wrist
    Edge.index( 6,  8), // right_shoulder to right_elbow
    Edge.index( 8, 10), // right_elbow to right_wrist
    Edge.index( 5,  6), // left_shoulder to right_shoulder
    Edge.index( 5, 11), // left_shoulder to left_hip
    Edge.index( 6, 12), // right_shoulder to right_hip
    Edge.index(11, 12), // left_hip to right_hip
    Edge.index(11, 13), // left_hip to left_knee
    Edge.index(13, 15), // left_knee to left_ankle
    Edge.index(12, 14), // right_hip to right_knee
    Edge.index(14, 16), // right_knee to right_ankle
  ];

  static double getAngle(List<int> pointA, List<int> pointB, List<int> pointC) {
    double radians = atan2(pointC[1] - pointB[1], pointC[0] - pointB[0]) -
        atan2(pointA[1] - pointB[1], pointA[0] - pointB[0]);
    double angle = (radians * 180 / pi).abs();
    if (angle > 180) angle = 360 - angle;

    return angle;
  }

  late List<dynamic> inferences;
  late List<Limb> limbs;

  int count = 0;

  WorkoutView beforeView = WorkoutView.front;

  List<WorkoutDistance> distanceHistory = [];
  List<WorkoutView> viewHistory = [];
  List<WorkoutStage> stageHistory = [];

  void addDistanceHistory(WorkoutDistance distance) {
    distanceHistory.add(distance);
    if (distanceHistory.length > 50) distanceHistory.removeAt(0);
  }

  void addViewHistory(WorkoutView view) {
    viewHistory.add(view);
    if (viewHistory.length > 50) viewHistory.removeAt(0);
  }

  void addStageHistory(WorkoutStage stage) {
    stageHistory.add(stage);
    if (stageHistory.length > 15) stageHistory.removeAt(0);
  }

  WorkoutDistance get decideDistance {
    int max = 0;
    late WorkoutDistance maxDistance;

    for (WorkoutDistance distance in distanceHistory) {
      int temp = distanceHistory.where((d) => d == distance).length;
      if (max > temp) continue;
      max = temp;
      maxDistance = distance;
    }

    return maxDistance;
  }

  WorkoutView get decideView {
    int max = 0;
    late WorkoutView maxView;

    for (WorkoutView view in viewHistory) {
      int temp = viewHistory.where((v) => v == view).length;
      if (max > temp) continue;
      max = temp;
      maxView = view;
    }

    return maxView;
  }

  WorkoutDistance get distance {
    double noseY = inferences[Part.nose.index][1].toDouble();
    double ankleLY = inferences[Part.ankleL.index][1].toDouble();
    double ankleRY = inferences[Part.ankleR.index][1].toDouble();
    double ankleY = (ankleLY + ankleRY) / 2;
    double height = ankleY - noseY;

    WorkoutDistance currentDistance = WorkoutDistance.middle;

    if (height > 500) currentDistance = WorkoutDistance.near;
    if (height < 150) currentDistance = WorkoutDistance.far;

    addDistanceHistory(currentDistance);
    return decideDistance;
  }

  WorkoutView get view {
    double shoulderLX = inferences[Part.shoulderL.index][0].toDouble();
    double shoulderRX = inferences[Part.shoulderR.index][0].toDouble();
    double width = shoulderLX - shoulderRX;

    WorkoutView currentView = WorkoutView.side;

    if (distance != WorkoutDistance.middle) currentView = WorkoutView.unrecognized;
    if (width < 60 && width > 38) currentView = WorkoutView.front;
    if (width > -60 && width < -38) currentView = WorkoutView.back;

    addViewHistory(currentView);
    beforeView = decideView;
    return decideView;
  }

  void staging() {
    WorkoutStage stage = limbs.map((l) => l.isCorrect).any((i) => i)
        ? WorkoutStage.hit : WorkoutStage.ready;
    addStageHistory(stage);
    countUp();
  }

  void countUp() {
    if (distance != WorkoutDistance.middle) return;

    List<WorkoutStage> subList = stageHistory.sublist(0, stageHistory.length - 1);
    if ([...subList].where((s) => s == WorkoutStage.hit).length == 4
        && stageHistory.last == WorkoutStage.ready) count++;
  }
}