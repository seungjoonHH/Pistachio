import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/model/class/json/badge.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/model/collection.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/view/widget/function/dialog.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class CollectionMain extends GetxController {
  static Future<bool> toCollectionMain() async {
    final collectionMain = Get.find<CollectionMain>();
    collectionMain.init();
    return await Get.toNamed('/collection/main');
  }

  PageMode mode = PageMode.view;
  String? selectedBadgeId;

  void init() {
    final userPresenter = Get.find<UserPresenter>();
    selectedBadgeId = userPresenter.loggedUser.badgeId;
    mode = PageMode.view;
    update();
  }

  void toggleMode() {
    final userPresenter = Get.find<UserPresenter>();
    mode = PageMode.values[1 - mode.index];

    switch (mode) {
      case PageMode.view:
        userPresenter.loggedUser.badgeId = selectedBadgeId;
        userPresenter.save();
        showCollectionSettingDialog();
        break;
      default: break;
    }

    update();
  }

  void collectionPressed(Collection collection) {
    switch (mode) {
      case PageMode.view:
        GlobalPresenter.showCollectionDialog(collection);
        break;
      case PageMode.edit:
        collectionSelected(collection);
        break;
    }
    update();
  }

  void collectionSelected(Collection collection) {
    selectedBadgeId = selectedBadgeId == collection.badgeId
        ? null : selectedBadgeId = collection.badgeId;
    update();
  }

  void showCollectionSettingDialog() {
    Badge? selectedBadge = BadgePresenter.getBadge(selectedBadgeId);

    showPDialog(
      title: '대표 컬렉션 설정',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          selectedBadge == null ? PText('대표 컬렉션이 해제되었습니다.') : Column(
            children: [
              BadgeWidget(badge: selectedBadge, size: 100.0.r),
              SizedBox(height: 20.0.h),
              PText('대표 컬렉션이'),
              PTexts(
                [selectedBadge.title!, '로 설정되었습니다.'],
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
}