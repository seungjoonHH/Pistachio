
import 'package:get/get.dart';
import 'package:pistachio/model/enum/part.dart';
import 'package:pistachio/model/enum/workout.dart';
import 'package:pistachio/presenter/widget/painter.dart';

class AngleRange {
  late double min;
  late double max;

  AngleRange(this.min, this.max);

  bool inRange(double angle) => angle >= min && angle <= max;
}

class Limb {
  late Part part1;
  late Part part2;
  late Part part3;

  bool isCorrect = false;

  Map<WorkoutView, AngleRange> angleRanges = {};

  Limb(this.part1, this.part2, this.part3) { initAngles(); }
  Limb.list(List<Part> list) {
    part1 = list[0];
    part2 = list[1];
    part3 = list[2];
    initAngles();
  }
  Limb.intList(List<int> list) {
    part1 = Part.values[list[0]];
    part2 = Part.values[list[1]];
    part3 = Part.values[list[2]];
    initAngles();
  }

  void initAngles() {
    setAngles(WorkoutView.front, 0, 180);
    setAngles(WorkoutView.back, 0, 180);
    setAngles(WorkoutView.side, 0, 180);
    setAngles(WorkoutView.unrecognized, 0, 0);
  }

  void setAngles(WorkoutView view, double minAngle, double maxAngle) {
    angleRanges[view] = AngleRange(minAngle, maxAngle);
  }

  void correct(double angle) {
    final painterP = Get.find<PainterPresenter>();
    isCorrect = angleRanges[painterP.beforeView]!.inRange(angle);
  }

  bool contains(int index) {
    return [part1.index, part2.index, part3.index].contains(index);
  }
}