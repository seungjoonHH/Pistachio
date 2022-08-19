import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/view/page/home/widget.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:pistachio/view/widget/widget/bottom_bar.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: GlobalPresenter.closeBottomBar,
      child: const Scaffold(
        appBar: HomeAppBar(),
        bottomSheet: PBottomSheetBar(body: HomeView()),
      ),
    );
  }
}