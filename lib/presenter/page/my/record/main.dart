import 'package:get/get.dart';
import 'package:pistachio/model/enum/enum.dart';

class MyRecordMain extends GetxController {
  static void toMyRecordMain(ActivityType type) {
    Get.toNamed('my/record/main', arguments: type);
  }
}