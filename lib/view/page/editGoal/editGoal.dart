import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/page/editGoal.dart';
import 'package:pistachio/view/page/editGoal//widget.dart';

class EditGoalPage extends StatefulWidget {
  const EditGoalPage({Key? key}) : super(key: key);

  @override
  State<EditGoalPage> createState() => _EditGoalPageState();
}

class _EditGoalPageState extends State<EditGoalPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: GetBuilder<EditGoalPresenter>(builder: (controller) {
        controller
            .setKeyboardVisible(MediaQuery.of(context).viewInsets.bottom != 0);
        return const Scaffold(
          backgroundColor: PTheme.background,
          body: CarouselView(),
        );
      }),
    );
  }
}
