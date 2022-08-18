import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/collection.dart';
import 'package:pistachio/presenter/model/exercise.dart';
import 'package:pistachio/presenter/model/level.dart';
import 'package:pistachio/presenter/model/quest.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/page/complete.dart';
import 'package:pistachio/presenter/page/exercise/main.dart';
import 'package:pistachio/presenter/notification.dart';
import 'package:pistachio/presenter/page/exercise/setting/detail.dart';
import 'package:get/get.dart';
import 'package:pistachio/presenter/page/home.dart';
import 'package:pistachio/presenter/page/record/main.dart';
import 'package:pistachio/presenter/page/register.dart';

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

  static final barCont = BottomSheetBarController();

  static void initControllers() {
    Get.put(GlobalPresenter());

    Get.put(UserPresenter());
    Get.put(ExercisePresenter());
    Get.put(ChallengePresenter());
    Get.put(CollectionPresenter());
    Get.put(LevelPresenter());
    Get.put(QuestPresenter());

    Get.put(RegisterPresenter());
    Get.put(HomePresenter());
    Get.put(CompletePresenter());
    Get.put(RegisterPresenter());
    Get.put(NotificationPresenter());
    Get.put(ExerciseMain());
    Get.put(ExerciseDetailSetting());
    Get.put(RecordMain());
  }

  static void importData() {
    final exercisePresenter = Get.find<ExercisePresenter>();
    final collectionPresenter = Get.find<CollectionPresenter>();
    final challengePresenter = Get.find<ChallengePresenter>();
    final levelPresenter = Get.find<LevelPresenter>();
    final questPresenter = Get.find<QuestPresenter>();
    exercisePresenter.importFile();
    collectionPresenter.importFile();
    challengePresenter.importFile();
    challengePresenter.importFile();
    levelPresenter.importFile(ActivityType.distance);
    levelPresenter.importFile(ActivityType.height);
    levelPresenter.importFile(ActivityType.weight);
    questPresenter.importFile();
  }
}
