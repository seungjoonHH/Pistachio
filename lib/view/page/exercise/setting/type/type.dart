import 'package:pistachio/view/page/exercise/setting/type/widget.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:flutter/material.dart';

class ExerciseTypeSettingPage extends StatelessWidget {
  const ExerciseTypeSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: ExerciseTypeView(),
    );
  }
}
