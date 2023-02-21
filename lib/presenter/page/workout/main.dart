import 'package:get/get.dart';
import 'package:pistachio/model/enum/activity_type.dart';
import 'package:pistachio/model/enum/unit.dart';
import 'package:pistachio/presenter/model/record.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/home.dart';
import 'package:pistachio/presenter/widget/painter.dart';

class WorkoutMain extends GetxController {
  static void toWorkoutMain() {
    final workoutMain = Get.find<WorkoutMain>();
    workoutMain.init();
    Get.offNamed('workout/main');
  }

  void init() {
    final painterP = Get.find<PainterPresenter>();
    painterP.initCount();
  }

  void finishWorkout() async {
    final userP = Get.find<UserPresenter>();
    final homeP = Get.find<HomePresenter>();
    final painterP = Get.find<PainterPresenter>();

    Record record = Record.init(
      ActivityType.weight,
      painterP.count.toDouble(),
      ExerciseUnit.count,
    );
    userP.addRecord(ActivityType.weight, record);
    Get.back();
    homeP.init();
  }
}