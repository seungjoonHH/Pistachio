import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoadingPresenter extends GetxController {
  final refreshCont = RefreshController(initialRefresh: false);

  bool loading = false;
  Color mainColor = PTheme.black;
  Color color = PTheme.black;
  Timer? timer;

  void loadStart() {
    if (loading) return;
    loading = true;
    double opacity = .2;
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      opacity = ((opacity * 1000 + 3) % 200) / 1000;
      color = mainColor.withOpacity(.2 + opacity);
      update();
    });
  }
  void loadEnd() async {
    await Future.delayed(const Duration(milliseconds: 50), () {
      timer?.cancel();
      loading = false;
    });
    update();
  }

}