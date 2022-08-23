import 'package:flutter/material.dart';
import 'package:pistachio/view/page/monthlyQuest/widget.dart';
import '../../../global/theme.dart';
import '../../widget/widget/text.dart';

class MonthlyQuestPage extends StatelessWidget {
  const MonthlyQuestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PText('월간 목표', style: textTheme.titleMedium),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: PTheme.offWhite,
      body: const MonthlyQuestView(),
    );
  }
}
