import 'package:get/get.dart';
import 'package:pistachio/model/enum/activity_type.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/model/badge.dart';
import 'package:pistachio/presenter/model/height.dart';
import 'package:pistachio/presenter/model/level.dart';
import 'package:pistachio/presenter/model/quest.dart';
import 'package:pistachio/presenter/model/weight.dart';

class ImportPresenter extends GetxController {
  static void importData() {
    BadgePresenter.importFile();
    ChallengePresenter.importFile();
    WeightPresenter.importFile();
    HeightPresenter.importFile();
    LevelPresenter.importFile(ActivityType.calorie);
    LevelPresenter.importFile(ActivityType.distance);
    LevelPresenter.importFile(ActivityType.height);
    QuestPresenter.importFile();
  }
}