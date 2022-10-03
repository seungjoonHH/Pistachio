import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/page/my/main.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class PAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PAppBar({
    Key? key,
    this.title = '',
    this.color = PTheme.background,
    this.actions
  }) : super(key: key);

  final String title;
  final Color? color;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalPresenter>(
        builder: (controller) {
          return AppBar(
            elevation: 0.0,
            iconTheme: const IconThemeData(color: PTheme.black),
            backgroundColor: color,
            title: PText(title, style: textTheme.headlineMedium),
            // leading: IconButton(
            //   icon: const Icon(Icons.arrow_back_ios),
            //   onPressed: () {
            //     FocusScope.of(context).unfocus();
            //     Get.back();
            //   },
            // ),
            actions: actions,
          );
        }
    );
  }
}

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
          iconTheme: const IconThemeData(color: PTheme.white),
          backgroundColor: PTheme.background,
          title: const Align(
            alignment: Alignment.centerRight,
            child: MyNavigationButton(),
          ),
        );
      }
    );
  }
}

class MyNavigationButton extends StatelessWidget {
  const MyNavigationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius radius = BorderRadius.circular(18.0);

    return Material(
      color: PTheme.colorB,
      borderRadius: radius,
      shadowColor: PTheme.grey,
      child: InkWell(
        onTap: MyMain.toMyMain,
        borderRadius: radius,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0, vertical: 5.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: PTheme.black,
              width: 1.5,
            ),
            borderRadius: radius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_outline, color: PTheme.white),
              const SizedBox(width: 5.0),
              PText('나의 기록', color: PTheme.white),
            ],
          ),
        ),
      ),
    );
  }
}
