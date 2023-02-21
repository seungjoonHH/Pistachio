import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/number.dart';
import 'package:pistachio/model/class/workout/edge.dart';
import 'package:pistachio/model/class/workout/handler.dart';
import 'package:pistachio/model/class/workout/limb.dart';
import 'package:pistachio/model/enum/part.dart';
import 'package:pistachio/model/enum/workout.dart';

class PainterPresenter extends GetxController {
  static Orientation orientation = Orientation.portrait;
  static double get screenRatio {
    const ratio = 3 / 4;
    if (orientation == Orientation.portrait) return ratio;
    return 1 / ratio;
  }
  static double get _canvasHeight =>
      MediaQuery.of(Get.context!).size.height * .74;
  static Size get canvasSize => Size(
    _canvasHeight * screenRatio,
    _canvasHeight,
  );

  static void setOrientation(Orientation orientation) {
    PainterPresenter.orientation = orientation;
  }

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

  static double getAngle(Point pointA, Point pointB, Point pointC) {
    double radians = atan2(pointC.y - pointB.y, pointC.x - pointB.x) -
        atan2(pointA.y - pointB.y, pointA.x - pointB.x);
    double angle = (radians * 180 / pi).abs();
    if (angle > 180) angle = 360 - angle;

    return angle;
  }

  late List<dynamic> inferences;
  late List<Limb> limbs;

  int count = 0;
  bool allowCount = true;
  String? floatingMessage;

  // WorkoutView beforeView = WorkoutView.front;
  WorkoutStage beforeStage = WorkoutStage.ready;
  WorkoutStage currentStage = WorkoutStage.ready;
  WorkoutState state = WorkoutState.stop;

  String? stateText;

  static List<WorkoutDistance> distanceHistory = [];
  // static List<WorkoutView> viewHistory = [];
  static List<bool> hitHistory = [];
  static int humanHistory = 0;

  static void addDistanceHistory(WorkoutDistance distance) {
    distanceHistory.add(distance);
    if (distanceHistory.length > 50) distanceHistory.removeAt(0);
  }

  // static void addViewHistory(WorkoutView view) {
  //   viewHistory.add(view);
  //   if (viewHistory.length > 50) viewHistory.removeAt(0);
  // }

  static void addHitHistory(bool hit) {
    hitHistory.add(hit);
    if (hitHistory.length > 5) hitHistory.removeAt(0);
  }

  static void addHumanHistory(bool isHuman) {
    int after = humanHistory + (isHuman ? 1 : -1);
    humanHistory = max(min(after, 10), -30);
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

  // WorkoutView get decideView {
  //   int max = 0;
  //   late WorkoutView maxView;
  //
  //   for (WorkoutView view in viewHistory) {
  //     int temp = viewHistory.where((v) => v == view).length;
  //     if (max > temp) continue;
  //     max = temp;
  //     maxView = view;
  //   }
  //
  //   return maxView;
  // }

  WorkoutDistance get distance {
    double hipLY = inferences[Part.hipL.index][1].toDouble();
    double hipRY = inferences[Part.hipR.index][1].toDouble();
    double ankleLY = inferences[Part.ankleL.index][1].toDouble();
    double ankleRY = inferences[Part.ankleR.index][1].toDouble();
    double legHeight = average([ankleLY, ankleRY]).toDouble() - average([hipLY, hipRY]);

    WorkoutDistance currentDistance = WorkoutDistance.middle;

    if (legHeight > 350) {
      currentDistance = WorkoutDistance.near;
      floatingMessage = '너무 가까워요!';
    }
    if (legHeight < 50 + (currentStage != WorkoutStage.ready ? 0 : 20)) {
      currentDistance = WorkoutDistance.far;
      floatingMessage = '좀 더 가까이 와주세요.';
    }

    addDistanceHistory(currentDistance);
    return decideDistance;
  }

  // WorkoutView get view {
  //   try {
  //     double shoulderLX = inferences[Part.shoulderL.index][0].toDouble();
  //     double shoulderRX = inferences[Part.shoulderR.index][0].toDouble();
  //     double width = shoulderLX - shoulderRX;
  //
  //     WorkoutView currentView = WorkoutView.front;
  //
  //     if (humanHistory < 0
  //         || distance != WorkoutDistance.middle) {
  //       currentView = WorkoutView.unrecognized;
  //       floatingMessage = '사람이 인식되지 않아요.';
  //     }
  //     if (width < 60 && width > 38) currentView = WorkoutView.front;
  //     if (width > -60 && width < -38) currentView = WorkoutView.back;
  //
  //     addViewHistory(currentView);
  //     beforeView = decideView;
  //     return decideView;
  //   }
  //   catch (e) { return WorkoutView.unrecognized; }
  // }

  void staging() {
    addHitHistory(ExerciseHandler.posture != WorkoutPosture.ready);
    countUp();
  }

  void countUp() {
    if (humanHistory < 0 || distance != WorkoutDistance.middle) {
      floatingMessage = '사람이 인식되지 않습니다';
      return;
    }

    if (currentStage == WorkoutStage.fast) return;

    List<bool> subList = hitHistory.sublist(0, hitHistory.length - 1);

    late bool upCond, downCond, countCond;

    upCond = currentStage == WorkoutStage.up;
    upCond &= [...subList].every((s) => s);
    upCond &= !hitHistory.last;

    downCond = currentStage == WorkoutStage.down;
    downCond &= [...subList].every((s) => !s);
    downCond &= hitHistory.last;

    beforeStage = currentStage;

    if (downCond) currentStage = WorkoutStage.up;
    if (upCond) currentStage = WorkoutStage.down;

    countCond = beforeStage == WorkoutStage.down;
    countCond &= currentStage == WorkoutStage.up;

    floatingMessage = null;

    print(countCond);
    print(state);
    print('');
    if (state == WorkoutState.workout) {
      switch (ExerciseHandler.posture) {
        case WorkoutPosture.correct:
          if (countCond) {
            if (allowCount) {
              count++;
              allowCount = false;
              stateText = 'HIT!';
              Future.delayed(const Duration(milliseconds: 1500), () {
                currentStage = WorkoutStage.down;
                allowCount = true;
                stateText = null;
              });
              return;
            }
            currentStage = WorkoutStage.fast;
            floatingMessage = '조금만 더 천천히 해주세요';
          }
          break;
        case WorkoutPosture.wrong:
          floatingMessage = '자세를 바르게 해주세요';
          break;
        default: break;
      }
    }
  }

  void initCount() {
    count = 0;
    state = WorkoutState.stop;
    stateText = '';
    update();
  }

  void workout() {
    switch (state) {
      case WorkoutState.stop:
        stateText = 'READY';
        state = WorkoutState.ready;
        Future.delayed(const Duration(milliseconds: 2000), () {
          stateText = 'GO!'; update();
          Future.delayed(const Duration(milliseconds: 1000), () {
            state = WorkoutState.workout;
            currentStage = WorkoutStage.down;
            stateText = null; update();
          });
        });
        update();
        break;
      case WorkoutState.ready: break;
      case WorkoutState.workout:
        state = WorkoutState.stop;
        currentStage = WorkoutStage.ready;
        update();
        break;
    }

  }
}