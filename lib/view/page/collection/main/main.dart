import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/colllection/main.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:pistachio/view/widget/widget/badge.dart';

class CollectionMainPage extends StatelessWidget {
  const CollectionMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userPresenter = Get.find<UserPresenter>();
    const collectionCounts = 99;

    List<Widget> collectionWidgets = userPresenter
        .myCollections.map((collection) {
      return Center(
        child: CollectionWidget(
          collection: collection,
          detail: true,
          size: 100.0,
          onPressed: () => GlobalPresenter.collectionPressed(collection),
        ),
      );
    }).toList();

    List<Widget> emptyWidgets = List.generate(
      (collectionCounts - collectionWidgets.length).toInt(),
      (_) => const Center(child: CollectionWidget(size: 100.0)),
    ).toList();

    List<Widget> gridWidgets = collectionWidgets..addAll(emptyWidgets);

    return Scaffold(
      backgroundColor: PTheme.background,
      appBar: const PAppBar(title: '컬렉션'),
      body: GridView(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: .65,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        children: gridWidgets,
      ),
    );
  }
}
