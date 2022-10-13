/* 마이 페이지 위젯 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/global/unit.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/model/collection.dart';
import 'package:pistachio/presenter/model/level.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/my/setting/main.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class MyMainView extends StatefulWidget {
  const MyMainView({Key? key}) : super(key: key);

  @override
  State<MyMainView> createState() => _MyMainViewState();
}

class _MyMainViewState extends State<MyMainView> {
  @override
  Widget build(BuildContext context) {
    PUser loggedUser = Get.find<UserPresenter>().loggedUser;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyProfileWidget(),
          const SizedBox(height: 30.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText('개인 누적 기록치', style: textTheme.headlineSmall),
                const SizedBox(height: 20.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ActivityType.activeValues.map((type) {
                      Map<String, dynamic> tier = LevelPresenter
                          .getTier(type, loggedUser.getAmounts(type));

                      return Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 60.0,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      PText(tier['current'] ?? '',
                                        maxLines: 2,
                                        style: textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: PTheme.black, width: 1.5),
                                          borderRadius: BorderRadius.circular(9.0)
                                        ),
                                        child: LinearPercentIndicator(
                                          padding: EdgeInsets.zero,
                                          progressColor: type.color,
                                          backgroundColor: Colors.transparent,
                                          percent: tier['percent'] ?? .0,
                                          lineHeight: 18.0,
                                          barRadius: const Radius.circular(8.0),
                                          animation: true,
                                          animationDuration: 1000,
                                          curve: Curves.easeInOut,
                                        ),
                                      ),
                                      PText(tier['next'] ?? ''),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 60.0,
                                  child: PText(
                                    '${(100 * (tier['percent'] ?? 0)).round()}%',
                                    style: textTheme.headlineSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyProfileWidget extends StatelessWidget {
  const MyProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPresenter>(
      builder: (controller) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BadgeWidget(
              badge: BadgePresenter.getBadge(controller.loggedUser.badgeId),
              size: 100.0,
              onPressed: () {
                Collection? collection = controller.loggedUser.collection;
                if (collection == null) return;
                GlobalPresenter.showCollectionDialog(collection);
              },
            ),
            const SizedBox(width: 20.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText(controller.loggedUser.nickname!,
                  style: textTheme.displaySmall,
                ),
                PText('${height}cm | ${weight}kg',
                  style: textTheme.titleLarge,
                  color: PTheme.grey,
                ),
              ],
            ),
          ]
        );
      },
    );
  }
}