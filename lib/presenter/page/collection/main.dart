import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/string.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/model/class/json/badge.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/model/badge.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/view/widget/function/dialog.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/text.dart';

/// class
class CollectionMain extends GetxController {
  /// static methods
  // 컬렉션 메인 페이지로 이동
  static Future<bool> toCollectionMain() async {
    final collectionMain = Get.find<CollectionMain>();
    collectionMain.init();
    return await Get.toNamed('/collection/main');
  }

  /// attributes
  PageMode mode = PageMode.view;
  String? selectedBadgeId;

  /// methods
  // 초기화
  void init() {
    final userP = Get.find<UserPresenter>();
    selectedBadgeId = userP.loggedUser.badgeId;
    mode = PageMode.view;
    update();
  }

  // 편집, 읽기전용 모드 변환
  void toggleMode() {
    final userP = Get.find<UserPresenter>();
    mode = PageMode.values[1 - mode.index];

    switch (mode) {
      case PageMode.view:
        userP.loggedUser.badgeId = selectedBadgeId;
        userP.save();
        showCollectionSettingDialog();
        break;
      default: break;
    }

    update();
  }

  // 컬렉션 클릭 시
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

  // 편집모드에서 컬렉션 선택 시
  void collectionSelected(Collection collection) {
    selectedBadgeId = selectedBadgeId == collection.badgeId
        ? null : selectedBadgeId = collection.badgeId;
    update();
  }

  // 대표 컬렉션 설정 팝업
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
                [selectedBadge.title!, '${roeuro(selectedBadge.title!)} 설정되었습니다.'],
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