import 'package:pistachio/presenter/model/collection.dart';
import 'package:pistachio/presenter/model/exercise.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/page/complete.dart';
import 'package:pistachio/presenter/page/exercise/main.dart';
import 'package:pistachio/presenter/page/exercise/setting/detail.dart';
import 'package:get/get.dart';
import 'package:pistachio/presenter/page/home.dart';

class GlobalPresenter extends GetxController {
  int navIndex = 0;

  void navigate(int index) {
    navIndex = index;

    switch (navIndex) {
      case 0: HomePresenter.toHome(); break;
      case 1: ChallengePresenter.toChallengeMain(); break;
      case 2: break;
      case 3: break;
      case 4: break;
    }
    update();
  }


  static void initControllers() {
    Get.put(GlobalPresenter());

    Get.put(UserPresenter());

    Get.put(HomePresenter());
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
    final challengePresenter = Get.find<ChallengePresenter>();
    exercisePresenter.importFile();
    collectionPresenter.importFile();
    challengePresenter.importFile();
  }
}
