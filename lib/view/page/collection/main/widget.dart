import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/collection/main.dart';
import 'package:pistachio/view/widget/widget/badge.dart';

class CollectionMainView extends StatelessWidget {
  const CollectionMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CollectionMain>(
      builder: (controller) {
        final userP = Get.find<UserPresenter>();
        PUser user = userP.loggedUser;
        const collectionCounts = 99;

        List<Widget> collectionWidgets = user.collections.map((collection) {
          return Center(
            child: CollectionWidget(
              collection: collection,
              detail: true,
              size: 100.0,
              onPressed: () => controller.collectionPressed(collection),
              onLongPressed: () {
                controller.toggleMode();
                controller.collectionPressed(collection);
              },
              pressed: controller.mode == PageMode.edit
                  && controller.selectedBadgeId == collection.badgeId,
              selected: controller.mode == PageMode.view
                  && user.badgeId == collection.badgeId,
            ),
          );
        }).toList();

        List<Widget> emptyWidgets = List.generate(
          (collectionCounts - collectionWidgets.length).toInt(),
              (_) => const Center(child: CollectionWidget(size: 100.0)),
        ).toList();

        List<Widget> gridWidgets = collectionWidgets..addAll(emptyWidgets);

        return GridView(
          padding: const EdgeInsets.all(20.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .65,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          children: gridWidgets,
        );
      }
    );
  }
}
