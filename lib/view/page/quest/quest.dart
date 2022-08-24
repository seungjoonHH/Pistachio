import 'package:flutter/material.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/page/quest/widget.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class QuestPage extends StatelessWidget {
  const QuestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PText('월간 목표', style: textTheme.titleMedium),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: PTheme.background,
      body: const MonthlyQuestView(),
    );
  }
}
