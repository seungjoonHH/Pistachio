import 'package:get/get.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/model/badge.dart';
import 'package:pistachio/presenter/model/level.dart';
import 'package:pistachio/presenter/model/quest.dart';

class ImportPresenter extends GetxController {
  static void importData() {
    BadgePresenter.importFile();
    ChallengePresenter.importFile();
    LevelPresenter.importFile(ActivityType.calorie);
    LevelPresenter.importFile(ActivityType.distance);
    LevelPresenter.importFile(ActivityType.height);
    QuestPresenter.importFile();
  }
}