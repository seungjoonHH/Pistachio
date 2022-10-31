import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/view/page/my/record/widget.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'background/layout/layout_colors.dart';

class MyRecordPage extends StatelessWidget {
  const MyRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.arguments == null) return const Scaffold();
    ActivityType type = Get.arguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: PuzzleColors.waterLight,
      appBar: const PAppBar(color: Colors.transparent),
      body: MyRecordDetailView(type: type),
    );
  }
}
