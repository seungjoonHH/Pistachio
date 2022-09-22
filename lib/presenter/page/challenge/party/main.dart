import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:pistachio/model/class/party.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';

class ChallengePartyMain extends GetxController {
  static void toChallengePartyMain(Party party) {
    final challengePartyMain = Get.find<ChallengePartyMain>();
    Get.toNamed('challenge/party/main', arguments: party);
    challengePartyMain.init();
  }
  int value = 0;
  int maxValue = 0;
  Timer? timer;
  static const int millisecond = 500;

  void init() {
    final userPresenter = Get.find<UserPresenter>();
    value = 0;
    maxValue = userPresenter.loggedUser
        .getThisMonthAmounts(ActivityType.weight);
    animateValue();
  }

  void animateValue() {
    const int intervalMilli = 10;
    int interval = maxValue ~/ (millisecond / intervalMilli);

    timer = Timer.periodic(const Duration(milliseconds: intervalMilli), (timer) {
      value = min(value + interval, maxValue);
      if (value >= maxValue) timer.cancel();
      update();
    });
    update();
  }
  
}