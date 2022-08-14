/* 운동 상세 설정 페이지 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/page/exercise/setting/detail/widget.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:flutter/material.dart';

/// class
class ExerciseDetailSettingPage extends StatelessWidget {
  const ExerciseDetailSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const HomeAppBar(),
      body: const ExerciseDetailSettingView(),
    );
  }
}
