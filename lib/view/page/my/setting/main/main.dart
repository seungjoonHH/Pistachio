/* 설정 페이지 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/page/my/setting/main/widget.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:pistachio/view/widget/widget/bottom_bar.dart';
import 'package:flutter/material.dart';

// 세팅 페이지
class MySettingMainPage extends StatelessWidget {
  const MySettingMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: PTheme.background,
      appBar: MySettingMainAppBar(),
      body: MySettingMainView(),
    );
  }
}
