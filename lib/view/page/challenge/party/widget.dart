import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/challenge/party/main.dart';
import 'package:pistachio/presenter/widget/loading.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PartyMainView extends StatelessWidget {
  const PartyMainView({
    Key? key,
    required this.party,
  }) : super(key: key);

  final Party? party;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChallengePartyMain>(
      builder: (challengePartyMain) {
        return GetBuilder<LoadingPresenter>(
          builder: (loadingP) {
            return SmartRefresher(
              controller: ChallengePartyMain.refreshCont,
              onRefresh: () async {
                loadingP.loadStart();
                await challengePartyMain.init(party!.id!);
                loadingP.loadEnd();
                ChallengePartyMain.refreshCont.refreshCompleted();
              },
              onLoading: () async {
                await Future.delayed(const Duration(milliseconds: 100));
                ChallengePartyMain.refreshCont.loadComplete();
              },
              header: const MaterialClassicHeader(
                color: PTheme.black,
                backgroundColor: PTheme.surface,
              ),
              child: !loadingP.loading || party == null
                  ? SingleChildScrollView(
                child: Column(
                  children: [
                    ChallengeInfoWidget(party: party!),
                    const Divider(
                      color: PTheme.lightGrey,
                      thickness: 8,
                    ),
                    MyScoreWidget(party: party!),
                    const Divider(
                      color: PTheme.lightGrey,
                      thickness: 8,
                    ),
                    RankWidget(party: party!),
                  ],
                ),
              ) : ChallengePartyMainLoading(color: loadingP.color),
            );
          },
        );
      },
    );
  }
}

class ChallengeInfoWidget extends StatelessWidget {
  const ChallengeInfoWidget({
    Key? key,
    required this.party,
  }) : super(key: key);

  final Party party;

  @override
  Widget build(BuildContext context) {
    BorderRadius imageRadius = BorderRadius.all(Radius.circular(20.0.r));

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: imageRadius,
                child: Image.asset(
                  party.challenge?.imageUrls['default'],
                  fit: BoxFit.fill,
                  height: 200.0.h,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: imageRadius,
                    gradient: LinearGradient(
                      colors: [
                        PTheme.black.withOpacity(.1),
                        PTheme.black.withOpacity(.3),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10.0.h, right: 10.0.w,
                child: GetBuilder<ChallengePartyMain>(
                  builder: (controller) {
                    return Material(
                      color: PTheme.white.withOpacity(.4),
                      borderRadius: BorderRadius.circular(10.0.r),
                      child: InkWell(
                        onTap: () => controller.copyPartyId(party.id!),
                        borderRadius: BorderRadius.circular(10.0.r),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 3.0,
                          ),
                          width: 140.0.w,
                          height: 30.0.h,
                          child: controller.copied
                              ? const Icon(
                            Icons.check,
                            color: PTheme.colorB,
                          ) : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PText(party.id!,
                                style: textTheme.titleLarge,
                                color: PTheme.colorB,
                              ),
                              const SizedBox(width: 5.0),
                              const Icon(
                                Icons.copy,
                                color: PTheme.colorB,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0.h),
          Container(
            alignment: Alignment.center,
            height: 40.0.h,
            child: PText('난이도: ${party.difficulty.kr}',
              style: textTheme.labelLarge,
              color: PTheme.grey,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 40.0.h,
            child: PText(party.challenge?.titleOneLine ?? '',
              style: textTheme.headlineSmall,
              maxLines: 2,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 160.0.h,
            child: PText(
              party.challenge?.descriptions['detail']!.replaceAll('##', party.challenge!.word),
              style: textTheme.labelLarge,
              color: PTheme.grey,
              align: TextAlign.center,
              maxLines: 7,
            ),
          ),
        ],
      ),
    );
  }
}

class MyScoreWidget extends StatelessWidget {
  const MyScoreWidget({
    Key? key,
    required this.party,
  }) : super(key: key);

  final Party party;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              PText('내 점수',
                style: textTheme.headlineSmall,
                color: PTheme.black,
              ),
              const SizedBox(width: 10.0),
              PText('*현재 챌린지 기준',
                style: textTheme.bodySmall,
                color: PTheme.grey,
              ),
            ],
          ),
          const SizedBox(height: 50.0),
          GetBuilder<ChallengePartyMain>(
            builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedFlipCounter(
                    value: controller.value.toInt(),
                    textStyle: textTheme.displayLarge?.apply(
                      color: party.challenge!.type!.color,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  PText(party.challenge!.type!.unitAlt,
                    style: textTheme.bodySmall,
                    color: PTheme.grey,
                  ),
                ],
              );
            }
          ),
        ],
      ),
    );
  }
}

class RankWidget extends StatelessWidget {
  const RankWidget({
    Key? key,
    required this.party,
  }) : super(key: key);

  final Party party;

  @override
  Widget build(BuildContext context) {
    PUser user = Get.find<UserPresenter>().loggedUser;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      PText('순위',
                        style: textTheme.headlineSmall,
                        color: PTheme.black,
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/image/page/challenge/trophy.png',
                    width: 100.0, height: 100.0,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PText('현재 1위: ${party.winner.nickname}',
                    style: textTheme.labelLarge,
                    color: PTheme.black,
                  ),
                  PText('나의 순위: ${party.getRank(user.uid!)}위',
                    style: textTheme.labelLarge,
                    color: PTheme.black,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          color: PTheme.grey,
          thickness: 1,
          height: 1.0,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: party.records.length,
          itemBuilder: (context, index) {
            PUser loggedUser = Get.find<UserPresenter>().loggedUser;
            PUser user = party.getMemberByRank(index + 1);

            return Container(
              color: user.uid == loggedUser.uid ? PTheme.bar : null,
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PText('${index + 1}'),
                  BadgeWidget(
                    badge: user.collection?.badge, size: 40.0,
                    onPressed: () => GlobalPresenter.showBadgeDialog(user.collection?.badge),
                  ),
                  SizedBox(
                    width: 130.0.w,
                    child: PText(user.nickname!),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 70.0.w,
                    child: PText(
                      '${party.records[user.uid!]}${party.challenge!.type!.unit}',
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            color: PTheme.grey,
            thickness: 1,
            height: 1.0,
          ),
        ),
        const Divider(
          color: PTheme.grey,
          thickness: 1,
          height: 1.0,
        ),
        const SizedBox(height: 100.0),
      ],
    );
  }
}

class ChallengePartyMainLoading extends StatelessWidget {
  const ChallengePartyMainLoading({
    Key? key,
    this.color = PTheme.black,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
      color: color, borderRadius: BorderRadius.circular(15.0),
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(height: 200.0.h, decoration: decoration),
                SizedBox(height: 30.0.h),
                Container(width: 100.0.w, height: 20.0.h, decoration: decoration),
                SizedBox(height: 20.0.h),
                Container(height: 25.0.h, decoration: decoration),
                SizedBox(height: 20.0.h),
                Container(height: 140.0.h, decoration: decoration),
                SizedBox(height: 5.0.h),
              ],
            ),
          ),
          const Divider(color: PTheme.lightGrey, thickness: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 200.0.w, height: 25.0.h, decoration: decoration),
                SizedBox(height: 20.0.h),
                Container(height: 100.0.h, decoration: decoration),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
