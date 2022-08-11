import 'package:get/get.dart';

class ExerciseDetailSetting extends GetxController {
  int selectedIndex = 0;

  void selectExercise(int index) { selectedIndex = index; update(); }
}