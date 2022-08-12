import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalPresenter>(
      builder: (controller) {
        return AppBar(
          elevation: 0.0,
          title: PText('Pistachio',
            color: PTheme.light,
            style: textTheme.titleLarge,
          ),
          // leading: IconButton(
          //   icon: const Icon(Icons.menu),
          //   onPressed: () {},
          // ),
          iconTheme: const IconThemeData(color: PTheme.light),
          backgroundColor: PTheme.primary[30],
        );
      }
    );
  }
}