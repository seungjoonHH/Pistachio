import 'dart:math';

import 'package:pistachio/model/class/workout/limb.dart';
import 'package:pistachio/model/class/workout/parts.dart';
import 'package:pistachio/model/enum/part.dart';
import 'package:pistachio/model/enum/workout.dart';
import 'package:pistachio/presenter/widget/painter.dart';

class AngleRange {
  late double min;
  late double max;

  AngleRange(this.min, this.max);

  bool inRange(double angle) => angle >= min && angle <= max;
}

class ExerciseHandler {
  static WorkoutPosture posture = WorkoutPosture.ready;
  static late Parts parts;

  List<Limb> limbs = [];
  List<AngleRange> angleRanges = [];

  void init() {}
  void checkLimbs(List<dynamic> inference) {
    parts = Parts(inference);
    posture = WorkoutPosture.ready;
    bool downed = true;
    bool isCorrect = true;

    for (int i = 0; i < limbs.length; i++) {
      Part A = limbs[i].part1;
      Part B = limbs[i].part2;
      Part C = limbs[i].part3;

      Point pointA = parts.points[A]!;
      Point pointB = parts.points[B]!;
      Point pointC = parts.points[C]!;

      double angle = PainterPresenter.getAngle(pointA, pointB, pointC);

      downed &= angleRanges[i].inRange(angle);
      isCorrect &= Parts.similar(pointB.x, pointC.x);
    }

    isCorrect &= Parts.similar(parts.points[limbs[0].part3]!.y, parts.points[limbs[1].part3]!.y);

    if (downed) {
      posture = WorkoutPosture.wrong;
      if (isCorrect) posture = WorkoutPosture.correct;
    }
  }
}

class SquatHandler extends ExerciseHandler {
  @override
  void init() {
    limbs = [];
    limbs.add(Limb(Part.hipL, Part.kneeL, Part.ankleL));
    limbs.add(Limb(Part.hipR, Part.kneeR, Part.ankleR));

    angleRanges = [AngleRange(30, 150), AngleRange(30, 150)];
  }
}
