import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/presenter/page/my/setting/edit.dart';
import 'package:pistachio/presenter/page/my/setting/main.dart';
import 'package:pistachio/presenter/widget/loading.dart';
import 'package:pistachio/presenter/model/collection.dart';
import 'package:pistachio/presenter/model/level.dart';
import 'package:pistachio/presenter/model/party.dart';
import 'package:pistachio/presenter/model/quest.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/page/challenge/create.dart';
import 'package:pistachio/presenter/page/challenge/main.dart';
import 'package:pistachio/presenter/page/challenge/party/main.dart';
import 'package:pistachio/presenter/page/complete.dart';
import 'package:pistachio/presenter/page/exercise/input.dart';
import 'package:pistachio/presenter/page/exercise/main.dart';
import 'package:pistachio/presenter/notification.dart';
import 'package:pistachio/presenter/page/exercise/setting/detail.dart';
import 'package:pistachio/presenter/page/home.dart';
import 'package:pistachio/presenter/page/quest.dart';
import 'package:pistachio/presenter/page/onboarding.dart';
import 'package:pistachio/presenter/page/record/main.dart';
import 'package:pistachio/presenter/page/register.dart';
import 'package:pistachio/presenter/page/my/main.dart';
import 'package:pistachio/view/widget/function/dialog.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class GlobalPresenter extends GetxController {
  int navIndex = 0;

  void navigate(int index) {
    navIndex = index == 1 ? navIndex : index;

    switch (index) {
      case 0: HomePresenter.toHome(); break;
      case 1: openBottomBar(); break;
      case 2: ChallengeMain.toChallengeMain(); break;
    }
    update();
  }

  static final barCont = BottomSheetBarController();

  static void openBottomBar() async => await barCont.expand();
  static void closeBottomBar() async => await barCont.collapse();

  static void collectionPressed(Collection collection) {
    showPDialog(
      title: collection.badge!.title,
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CollectionWidget(collection: collection),
              const SizedBox(width: 20.0),
              Container(
                constraints: const BoxConstraints(maxHeight: 80.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: collection.dateList.map((date) => PText(
                      dateToString('yyyy-MM-dd 획득!', date.toDate())!,
                      color: date == collection.dateList.last
                          ? PTheme.colorB : PTheme.black,
                      bold: date == collection.dateList.last,
                    )).toList().reversed.toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.topLeft,
            constraints: const BoxConstraints(minHeight: 100.0),
            child: PText(collection.badge!.description!, maxLines: 5),
          ),
        ],
      ),
    );
  }

  static void initControllers() {
    Get.put(GlobalPresenter());

    Get.put(LoadingPresenter());

    Get.put(UserPresenter());
    Get.put(ChallengePresenter());
    Get.put(BadgePresenter());
    Get.put(LevelPresenter());
    Get.put(QuestPresenter());
    Get.put(PartyPresenter());

    Get.put(OnboardingPresenter());
    Get.put(RegisterPresenter());
    Get.put(HomePresenter());
    Get.put(CompletePresenter());
    Get.put(RegisterPresenter());
    Get.put(NotificationPresenter());
    Get.put(ExerciseMain());
    Get.put(ExerciseDetailSetting());
    Get.put(ExerciseInput());
    Get.put(RecordMain());
    Get.put(QuestMain());
    Get.put(MyMain());
    Get.put(MySettingMain());
    Get.put(MySettingEdit());
    Get.put(ChallengeMain());
    Get.put(ChallengeCreate());
    Get.put(ChallengePartyMain());
  }
}
