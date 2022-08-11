import 'package:pistachio/presenter/model/collection.dart';
import 'package:pistachio/presenter/model/exercise.dart';
import 'package:pistachio/presenter/page/challenge.dart';
import 'package:pistachio/presenter/page/complete.dart';
import 'package:pistachio/presenter/page/exercise/main.dart';
import 'package:pistachio/presenter/page/exercise/setting/detail.dart';
import 'package:get/get.dart';

class GlobalPresenter extends GetxController {
  static void initControllers() {
    Get.put(CompletePresenter());
    Get.put(ChallengePresenter());
    Get.put(CollectionPresenter());
    Get.put(ExercisePresenter());
    Get.put(ExerciseMain());
    Get.put(ExerciseDetailSetting());
  }

  static void importData() {
    final exercisePresenter = Get.find<ExercisePresenter>();
    final collectionPresenter = Get.find<CollectionPresenter>();
    exercisePresenter.importFile();
    collectionPresenter.importFile();
  }
}
