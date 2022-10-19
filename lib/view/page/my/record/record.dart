import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/view/page/my/record/widget.dart';
import '../../../../model/enum/enum.dart';

class MyRecordPage extends StatelessWidget {
  const MyRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.arguments == null) return const Scaffold();
    ActivityType type = Get.arguments;

    return Scaffold(
      appBar: AppBar(),
      body: MyRecordDetailView(type: type),
    );
  }
}
