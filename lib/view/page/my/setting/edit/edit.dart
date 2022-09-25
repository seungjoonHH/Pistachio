import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/page/my/setting/edit.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class MySettingEditPage extends StatelessWidget {
  const MySettingEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String editType = Get.arguments;

    return GetBuilder<MySettingEdit>(
      builder: (controller) {
        return Scaffold(
          appBar: PAppBar(
            title: '별명 수정',
            actions: [
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: controller.submit,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: PInputField(
              controller: MySettingEdit.editConts[editType]!,
            ),
          ),
          backgroundColor: PTheme.background,
        );
      },
    );
  }
}
