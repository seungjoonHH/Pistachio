import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/string.dart';
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
            title: '${MySettingEdit.kr[editType]} 수정',
            actions: [
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => controller.submit(editType),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: PInputField(
              controller: MySettingEdit.editConts[editType]!,
              invalid: controller.invalid,
              hintText: controller.hintText
                  ?? '${withEulReul(MySettingEdit.kr[editType]!)} 입력해주세요',
              hintColor: controller.hintText == null
                  ? PTheme.grey : PTheme.colorB,
            ),
          ),
        );
      },
    );
  }
}
