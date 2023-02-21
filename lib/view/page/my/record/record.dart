import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/activity_type.dart';
import 'package:pistachio/view/page/my/record/widget.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';

class MyRecordMainPage extends StatelessWidget {
  const MyRecordMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.arguments == null) return const Scaffold();
    ActivityType type = Get.arguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: PTheme.waterLight,
      appBar: const PAppBar(color: Colors.transparent),
      body: MyRecordDetailView(type: type),
    );
  }
}
