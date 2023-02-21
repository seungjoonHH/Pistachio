/* 마이 페이지 */

import 'package:pistachio/view/page/my/main/widget.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:flutter/material.dart';

class MyMainPage extends StatelessWidget {
  const MyMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyMainAppBar(),
      body: MyMainView(),
    );
  }
}