import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/presenter/widget/loading.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class ChallengeMain extends GetxController with GetSingleTickerProviderStateMixin {
  static final scrollCont = ScrollController();

  List<Widget> tabs = ['이달의 챌린지', '내 챌린지'].map((title) => PText(title)).toList();
  late TabController tabCont;

  static void toChallengeMain() async {
    final loadingPresenter = Get.find<LoadingPresenter>();
    final userPresenter = Get.find<UserPresenter>();
    loadingPresenter.loadStart();

    Get.offAllNamed('/challenge/main');
    await ChallengePresenter.importFile();
    await userPresenter.loadMyParties();

    loadingPresenter.loadEnd();
  }

  @override
  void onInit() {
    super.onInit();
    tabCont = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onClose() {
    tabCont.dispose();
    super.onClose();
  }
}
