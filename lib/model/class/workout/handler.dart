import 'package:pistachio/model/class/workout/limb.dart';
import 'package:pistachio/model/enum/part.dart';
import 'package:pistachio/model/enum/workout.dart';
import 'package:pistachio/presenter/widget/painter.dart';

class ExerciseHandler {
  late List<Limb> limbs;
  static late double errorX;
  static late double errorY;

  void init() {}
  void doReps(List<dynamic> inferenceResults) {}

  bool isPostureCorrect() {
    return limbs.map((limb) => !limb.isCorrect).every((i) => i);
  }

  void checkLimbs(List<dynamic> inferenceResults) {
    for (int i = 0; i < limbs.length; i++) {
      int A = limbs[i].part1.index;
      int B = limbs[i].part2.index;
      int C = limbs[i].part3.index;

      List<int> pointA = [inferenceResults[A][0], inferenceResults[A][1]];
      List<int> pointB = [inferenceResults[B][0], inferenceResults[B][1]];
      List<int> pointC = [inferenceResults[C][0], inferenceResults[C][1]];

      double angle = PainterPresenter.getAngle(pointA, pointB, pointC);
      limbs[i].correct(angle);
    }
  }
}

class SquatHandler extends ExerciseHandler {
  @override
  void init() {
    Limb limb1 = Limb(Part.hipL, Part.kneeL, Part.ankleL);
    Limb limb2 = Limb(Part.hipR, Part.kneeR, Part.ankleR);

    limb1.setAngles(WorkoutView.front, 30, 160);
    limb1.setAngles(WorkoutView.back, 30, 160);
    limb1.setAngles(WorkoutView.side, 30, 150);

    limb2.setAngles(WorkoutView.front, 30, 160);
    limb2.setAngles(WorkoutView.back, 30, 160);
    limb2.setAngles(WorkoutView.side, 30, 150);

    limbs = [limb1, limb2];

    ExerciseHandler.errorX = 0;
    ExerciseHandler.errorY = 0;
  }
}
