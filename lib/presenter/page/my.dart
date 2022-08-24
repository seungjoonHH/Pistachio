/* 마이 페이지 프리젠터 */

import 'package:pistachio/global/date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// class
class MyPresenter extends GetxController {

  /// static methods
  // 마이 페이지로 이동
  static void toMy() => Get.offAllNamed('/my');
}

