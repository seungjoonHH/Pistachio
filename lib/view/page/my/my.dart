/* 마이 페이지 */

import 'package:pistachio/view/page/my/widget.dart';
import 'package:pistachio/view/widget/widget/bottom_bar.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      bottomSheet: PBottomSheetBar(body: MyView()),
    );
  }
}
