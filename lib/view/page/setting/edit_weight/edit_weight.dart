/* 체중 수정 페이지 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/page/setting/setting.dart';
import 'package:pistachio/view/page/setting/edit_weight/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditWeightPage extends StatelessWidget {
  const EditWeightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: const EditWeightAppBar(),
          body: Center(
            child: Column(
              children: const [
                WeightTextField(),
              ],
            ),
          ),
        );
      }
    );
  }
}
