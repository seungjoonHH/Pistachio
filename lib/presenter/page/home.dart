import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePresenter extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() => scaffoldKey.currentState?.openDrawer();
  void closeDrawer() => scaffoldKey.currentState?.openEndDrawer();

  static void toHome() => Get.offAllNamed('/home');
}