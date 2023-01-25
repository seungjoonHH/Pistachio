import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/string.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/class/json/badge.dart';
import 'package:pistachio/model/enum/dialog.dart';
import 'package:pistachio/presenter/notification.dart';
import 'package:pistachio/presenter/page/collection/main.dart';
import 'package:pistachio/presenter/page/edit_goal.dart';
import 'package:pistachio/presenter/page/my/record/main.dart';
import 'package:pistachio/presenter/page/my/setting/edit.dart';
import 'package:pistachio/presenter/page/my/setting/main.dart';
import 'package:pistachio/presenter/page/workout/guide.dart';
import 'package:pistachio/presenter/page/workout/main.dart';
import 'package:pistachio/presenter/widget/camera.dart';
import 'package:pistachio/presenter/widget/loading.dart';
import 'package:pistachio/presenter/model/badge.dart';
import 'package:pistachio/presenter/model/level.dart';
import 'package:pistachio/presenter/model/party.dart';
import 'package:pistachio/presenter/model/quest.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/page/challenge/create.dart';
import 'package:pistachio/presenter/page/challenge/main.dart';
import 'package:pistachio/presenter/page/challenge/party/main.dart';
import 'package:pistachio/presenter/page/exercise/input.dart';
import 'package:pistachio/presenter/page/exercise/setting/detail.dart';
import 'package:pistachio/presenter/page/home.dart';
import 'package:pistachio/presenter/page/quest/main.dart';
import 'package:pistachio/presenter/page/onboarding.dart';
import 'package:pistachio/presenter/page/record/main.dart';
import 'package:pistachio/presenter/page/register.dart';
import 'package:pistachio/presenter/page/my/main.dart';
import 'package:pistachio/presenter/widget/painter.dart';
import 'package:pistachio/view/widget/effect/effect.dart';
import 'package:pistachio/view/widget/function/dialog.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class GlobalPresenter extends GetxController {
  static const String effectAsset =
      'assets/image/widget/dialog/badge_effect.png';
  static const String effect2Asset =
      'assets/image/widget/dialog/badge_effect2.png';

  int navIndex = 0;

  void navigate(int index) async {
    final homeP = Get.find<HomePresenter>();
    final challengeMain = Get.find<ChallengeMain>();

    switch (index) {
      case 0:
        if (navIndex == index) { homeP.init(); }
        else { HomePresenter.toHome(); }
        break;
      // case 1: openBottomBar(); break;
      case 1: WorkoutGuide.toWorkoutGuide(); break;
      case 2:
        if (navIndex == index) { challengeMain.init(); }
        else { ChallengeMain.toChallengeMain(); }
        break;
    }
    navIndex = index == 1 ? navIndex : index;
    update();
  }

  static final barCont = BottomSheetBarController();

  static Future openBottomBar() async => await barCont.expand();

  static Future closeBottomBar() async => await barCont.collapse();

  static void goBack() => Get.back(result: true);

  static void showBadgeDialog(PBadge? badge) {
    PUser user = Get.find<UserPresenter>().loggedUser;

    if (badge == null) return;

    bool have = user.collections
        .map((col) => col.badgeId!).contains(badge.id);

    if (have) {
      Collection collection = user.getCollectionsById(badge.id!)!;
      showCollectionDialog(collection);
      return;
    }

    showPDialog(
      title: badge.title,
      content: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                EternalRotation(
                  rps: .3,
                  child: Image.asset(
                    effect2Asset,
                    width: 180.0.r,
                    height: 180.0.r,
                  ),
                ),
                BadgeWidget(
                  badge: badge, size: 80.0.r,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.topLeft,
            child: PText(badge.toAcquire, maxLines: 5),
          ),
        ],
      ),
      type: DialogType.mono,
      onPressed: Get.back,
    );
  }

  static void showCollectionDialog(Collection? collection) {
    if (collection == null) return;

    PUser user = Get.find<UserPresenter>().loggedUser;
    bool isMainBadge = user.badgeId! == collection.badgeId;

    showPDialog(
      title: collection.badge!.title,
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 95.0.h,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CollectionWidget(
                      collection: collection,
                      onPressed: () {
                        Get.back();
                        CollectionMain.toCollectionMain();
                      },
                    ),
                    Container(
                      width: 30.0.r,
                      height: 30.0.r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: PTheme.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: PTheme.black, width: 1.5),
                      ),
                      child: PText('${collection.dates.length}', border: true),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20.0),
              Container(
                constraints: const BoxConstraints(maxHeight: 70.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: collection.dateList.map((date) => PText(
                        dateToString('yyyy-MM-dd 획득!', date.toDate())!,
                        color: date == collection.dateList.last
                            ? PTheme.colorB : PTheme.black,
                        bold: date == collection.dateList.last,
                      ),
                    ).toList().reversed.toList(),
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
      type: isMainBadge ? DialogType.mono : DialogType.bi,
      leftText: isMainBadge ? null : '대표 컬렉션으로 설정',
      leftPressed: isMainBadge ? null : (() async {
        Get.back();
        await Future.delayed(const Duration(milliseconds: 200));
        final collectionMain = Get.find<CollectionMain>();
        collectionMain.setMainBadge(collection);
      }),
      rightPressed: isMainBadge ? null : Get.back,
      onPressed: isMainBadge ? Get.back : null,
    );
  }

  static void showAwardedBadgeDialog(
    PBadge? badge,
    [bool firstAward = false]
  ) async {
    showPDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 300.0.w,
                height: 300.0.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (firstAward)
                    EternalRotation(
                      rps: .3,
                      child: Image.asset(
                        effectAsset,
                        width: 180.0.r,
                        height: 180.0.r,
                      ),
                    ),
                    BadgeWidget(
                      badge: badge,
                      size: 80.0.r,
                      onPressed: () {
                        Get.back();
                        CollectionMain.toCollectionMain();
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: .0,
                child: PText(
                  '${firstAward ? '신규' : ''} 뱃지 획득!',
                  style: textTheme.headlineSmall,
                ),
              ),
              Positioned(
                top: 40.0,
                right: 20.0,
                child: PText(
                  dateToString('yyyy-MM-dd', now)!,
                  color: PTheme.colorB,
                  align: TextAlign.end,
                ),
              ),
              Positioned(
                bottom: 20.0,
                child: Column(
                  children: [
                    PText(badge!.title!,
                      style: textTheme.titleLarge,
                      bold: true,
                    ),
                    const SizedBox(height: 5.0),
                    PText(badge.description!,
                      style: textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      type: DialogType.bi,
      leftText: '대표 컬렉션으로 설정',
      leftPressed: () async {
        Get.back();
        await Future.delayed(const Duration(milliseconds: 200));
        final userP = Get.find<UserPresenter>();
        userP.setMainBadge(badge.id!);
      },
      rightPressed: Get.back,
    );
  }


  // 대표 컬렉션 설정 팝업
  static void showCollectionSettingDialog(String badgeId) {
    PBadge? selectedBadge = BadgePresenter.getBadge(badgeId);

    showPDialog(
      title: '대표 컬렉션 변경',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          selectedBadge == null ? PText('대표 컬렉션이 해제되었습니다.') : Column(
            children: [
              BadgeWidget(badge: selectedBadge, size: 100.0.r),
              SizedBox(height: 20.0.h),
              PText('대표 컬렉션이'),
              PTexts(
                [selectedBadge.title!, '${roEuro(selectedBadge.title!)} 설정되었습니다.'],
                colors: const [PTheme.colorB, PTheme.black],
                space: false,
              )
            ],
          ),
        ],
      ),
      type: DialogType.mono,
      onPressed: Get.back,
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
    Get.put(RegisterPresenter());
    Get.put(NotificationPresenter());

    Get.put(ExerciseDetailSetting());
    Get.put(ExerciseInput());
    Get.put(RecordMain());
    Get.put(QuestMain());
    Get.put(MyMain());
    Get.put(MyRecordMain());
    Get.put(MySettingMain());
    Get.put(MySettingEdit());
    Get.put(ChallengeMain());
    Get.put(ChallengeCreate());
    Get.put(ChallengePartyMain());
    Get.put(CollectionMain());
    Get.put(EditGoal());
    Get.put(CameraPresenter());
    Get.put(PainterPresenter());
    Get.put(WorkoutMain());
  }
}
