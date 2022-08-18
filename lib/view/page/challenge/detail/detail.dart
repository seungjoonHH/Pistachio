/* 챌린지 메인 페이지 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/page/challenge/main/widget.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:flutter/material.dart';

/// class
class ChallengeMainPage extends StatelessWidget {
  const ChallengeMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      backgroundColor: colorScheme.background,
      body: const ChallengeListView(),
    );
  }
}
