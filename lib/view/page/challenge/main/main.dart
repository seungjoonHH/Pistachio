/* 챌린지 메인 페이지 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/view/page/challenge/main/widget.dart';
import 'package:flutter/material.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:pistachio/view/widget/widget/bottom_bar.dart';

/// class
class ChallengeMainPage extends StatelessWidget {
  const ChallengeMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: GlobalPresenter.closeBottomBar,
      child: const Scaffold(
        appBar: PAppBar(title: '챌린지'),
        backgroundColor: PTheme.background,
        bottomSheet: PBottomSheetBar(body: ChallengeMainView()),
      ),
    );
  }
}
