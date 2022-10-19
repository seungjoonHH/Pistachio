import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/presenter/page/challenge/party/main.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class PartyMainView extends StatelessWidget {
  const PartyMainView({
    Key? key,
    required this.party,
  }) : super(key: key);

  final Party party;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChallengePartyMain>(
      builder: (controller) {
        return Column(
          children: [
            Container(
              height: 200,
              width: 330,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child: Image.asset(
                  party.challenge?.imageUrls['default'],
                ),
              ),
            ),
            PText('난이도: ',
              style: textTheme.labelLarge,
              color: PTheme.grey,
            ),
            AnimatedFlipCounter(
              value: controller.value,
              textStyle: textTheme.displayLarge?.apply(color: PTheme.black),
            ),
            PText(party.challenge!.type!.unitAlt,
              style: textTheme.bodySmall,
              color: PTheme.grey,
            ),
          ],
        );
      }
    );
  }
}
