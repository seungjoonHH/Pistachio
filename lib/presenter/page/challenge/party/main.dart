import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/presenter/model/party.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/widget/loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChallengePartyMain extends GetxController {

  static void toChallengePartyMain(Party party) async {
    final challengePartyMain = Get.find<ChallengePartyMain>();
    final loadingPresenter = Get.find<LoadingPresenter>();

    Get.toNamed('challenge/party/main');

    loadingPresenter.loadStart();
    await challengePartyMain.init(party.id!);
    loadingPresenter.loadEnd();
  }

  double value = 0;
  double maxValue = 0;
  Timer? timer;
  Party? loadedParty;
  static const int millisecond = 500;

  bool copied = false;

  Future init(String id) async {
    final userPresenter = Get.find<UserPresenter>();

    loadedParty = await PartyPresenter.loadParty(id);
    await PartyPresenter.loadMembers(loadedParty!);
    await userPresenter.loadMyParties();

    PUser user = userPresenter.loggedUser;
    value = .0; update();
    maxValue = user.getAmounts(
      loadedParty!.challenge!.type!,
      loadedParty!.startDate,
      oneSecondBefore(tomorrow),
    ).toDouble();
    loadedParty!.records[user.uid!] = maxValue.toInt();
    animateValue();

    PartyPresenter.save(loadedParty!);
    update();
  }

  void animateValue() {
    const int intervalMilli = 10;
    double interval = maxValue / (millisecond / intervalMilli);

    timer = Timer.periodic(const Duration(milliseconds: intervalMilli), (timer) {
      value = min(value + interval, maxValue);
      if (value >= maxValue) timer.cancel();
      update();
    });
    update();
  }

  void copyPartyId(String id) async {
    Clipboard.setData(ClipboardData(text: id));
    copied = true; update();
    await Future.delayed(const Duration(milliseconds: 1000), () {
      copied = false; update();
    });
  }
}