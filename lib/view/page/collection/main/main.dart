import 'package:flutter/material.dart';
import 'package:pistachio/view/page/collection/main/widget.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';

class CollectionMainPage extends StatelessWidget {
  const CollectionMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CollectionMainAppBar(),
      body: CollectionMainView(),
    );
  }
}
