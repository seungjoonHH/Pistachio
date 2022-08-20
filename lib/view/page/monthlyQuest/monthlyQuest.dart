import 'package:flutter/material.dart';
import 'package:pistachio/view/page/monthlyQuest/widget.dart';
import '../../widget/widget/app_bar.dart';

class MonthlyQuestPage extends StatelessWidget {
  const MonthlyQuestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const MonthlyQuestView(),
    );
  }
}
