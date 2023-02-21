import 'package:flutter/material.dart';
import 'package:pistachio/view/page/quest/widget.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';

class QuestPage extends StatelessWidget {
  const QuestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PAppBar(title: '월간 목표'),
      body: MonthlyQuestView(),
    );
  }
}
