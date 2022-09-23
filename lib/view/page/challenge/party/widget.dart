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
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              iconTheme: const IconThemeData(color: PTheme.black),
              expandedHeight: 250.0,
              stretch: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  party.challenge?.imageUrls['default'],
                  fit: BoxFit.fitHeight,
                ),
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    AnimatedFlipCounter(
                      value: controller.value,
                      textStyle: textTheme.displayLarge?.apply(color: PTheme.black),
                    ),
                    PText(party.challenge!.type!.unitAlt,
                      style: textTheme.bodySmall,
                      color: PTheme.grey,
                    ),
                  ],
                ),
              ]),
            ),
          ],
        );
      }
    );
  }
}
