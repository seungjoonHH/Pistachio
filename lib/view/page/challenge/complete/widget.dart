/* 챌린지 완료 위젯 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/text.dart';

// 챌린지 완료 리스트 뷰
class ChallengeListView extends StatelessWidget {
  const ChallengeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<ChallengePresenter>(
        builder: (controller) {
          return Column(
            children: controller.challenges.map((ch) => ChallengeDetailBody(
              challenge: ch
            )).toList(),
          );
        }
      ),
    );
  }
}

class ChallengeCompleteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChallengeCompleteAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    Challenge challenge = Get.arguments;

    return GetBuilder<ChallengePresenter>(
        builder: (controller) {
          return AppBar(
            elevation: 0.0,
            iconTheme: const IconThemeData(color: PTheme.light),
            backgroundColor: challenge.theme['background'],
          );
        }
    );
  }
}

class ChallengeDetailBody extends StatelessWidget {
  const ChallengeDetailBody({Key? key, required this.challenge}) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SvgPicture.asset(
            challenge.imageUrls['complete'],
            width: 360.0,
            fit: BoxFit.fitHeight,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(34.0),
          child: PText(
            challenge.descriptions['complete']!.replaceAll('#', ''),
            style: textTheme.titleSmall,
            color: PTheme.white,
            maxLines: 7,
          ),
        ),
        Container(
          height: 130.0,
        ),
        Center(
          child: PButton(
            onPressed: () => ChallengePresenter.toChallengeMain(),
            text: '컬랙션 보러가기',
            //backgroundColor: challenge.theme['button'],
          ),
        )
      ],
    );
  }
}
