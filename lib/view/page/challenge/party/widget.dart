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
        return SingleChildScrollView(
          child: Column(
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
              const SizedBox(height:20),
              PText('난이도: 쉬움',
                style: textTheme.labelLarge,
                color: PTheme.grey,
              ),
              const SizedBox(height:20),
              PText(party.challenge?.title ?? '',
                style: textTheme.headlineSmall,
                maxLines: 2,
              ),
              const SizedBox(height:20),
              PText(
                party.challenge?.descriptions['detail']!,
                style: textTheme.labelLarge,
                color: PTheme.grey,
                maxLines: 7,
              ),
              const SizedBox(height:40),
              const Divider(
                color: PTheme.grey,
                thickness: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 30),
                child: Row(
                  children: [
                    PText('내 점수',
                      style: textTheme.headlineSmall,
                      color: PTheme.black,
                    ),
                    const SizedBox(width: 10),
                    PText('*현재 챌린지 기준',
                      style: textTheme.bodySmall,
                      color: PTheme.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height:50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  AnimatedFlipCounter(
                    value: controller.value,
                    textStyle: textTheme.displayLarge?.apply(color: PTheme.colorC),
                  ),
                  const SizedBox(width: 10),
                  PText(party.challenge!.type!.unitAlt,
                    style: textTheme.bodySmall,
                    color: PTheme.grey,
                  ),
                ],
              ),
              const SizedBox(height:50),
              const Divider(
                color: PTheme.grey,
                thickness: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 30, bottom: 30),
                child: Row(
                  children: [
                    PText('순위',
                      style: textTheme.headlineSmall,
                      color: PTheme.black,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/image/page/challenge/Trophy.png',
                ),
              ),
              const SizedBox(height:20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PText('현재 1위: 보거니',
                    style: textTheme.labelLarge,
                    color: PTheme.black,
                  ),
                  PText('나의 순위: 1위',
                    style: textTheme.labelLarge,
                    color: PTheme.black,
                  ),
                ],
              ),
              const SizedBox(height:20),
              const Divider(
                color: PTheme.grey,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Row(
                  children: [
                    PText('1',
                      style: textTheme.bodyLarge,
                      color: PTheme.black,
                    ),
                    const SizedBox(width:25),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        'assets/image/badge/1000000.png',
                      ),
                    ),
                    const SizedBox(width:25),
                    PText('닉네임',
                      style: textTheme.labelMedium,
                      color: PTheme.black,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: PTheme.grey,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Row(
                  children: [
                    PText('2',
                      style: textTheme.bodyLarge,
                      color: PTheme.black,
                    ),
                    const SizedBox(width:25),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        'assets/image/badge/1000000.png',
                      ),
                    ),
                    const SizedBox(width:25),
                    PText('닉네임',
                      style: textTheme.labelMedium,
                      color: PTheme.black,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: PTheme.grey,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Row(
                  children: [
                    PText('3',
                      style: textTheme.bodyLarge,
                      color: PTheme.black,
                    ),
                    const SizedBox(width:25),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        'assets/image/badge/1000000.png',
                      ),
                    ),
                    const SizedBox(width:25),
                    PText('닉네임',
                      style: textTheme.labelMedium,
                      color: PTheme.black,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: PTheme.grey,
                thickness: 1,
              ),
              const SizedBox(height:20),
            ],
          ),
        );
      }
    );
  }
}
