/* 마이 페이지 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/view/page/my/widget.dart';
import 'package:pistachio/view/widget/button/profile_image.dart';
import 'package:pistachio/view/widget/widget/bottom_bar.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userPresenter = Get.find<UserPresenter>();
    return Scaffold(
      appBar: const MyAppBar(),
      bottomSheet: PBottomSheetBar(body: MyView()),
    );
  }
}
