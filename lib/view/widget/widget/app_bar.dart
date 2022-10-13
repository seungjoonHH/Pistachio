import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/collection/main.dart';
import 'package:pistachio/presenter/page/my/main.dart';
import 'package:pistachio/presenter/page/my/setting/main.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class PAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PAppBar({
    Key? key,
    this.title = '',
    this.color = PTheme.background,
    this.leading,
    this.actions,
  }) : super(key: key);

  final String title;
  final Color? color;
  final Widget? leading;
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
            leading: leading,
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


class CollectionMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CollectionMainAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return PAppBar(
      title: '컬렉션',
      leading: const IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: GlobalPresenter.goBack,
      ),
      actions: [
        GetBuilder<CollectionMain>(
          builder: (controller) {
            return PTextButton(
              onPressed: controller.toggleMode,
              text: controller.mode == PageMode.view ? '편집' : '완료',
              style: textTheme.titleMedium,
              color: controller.mode == PageMode.view ? PTheme.black :  PTheme.colorB,
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            );
          },
        ),
      ],
    );
  }
}


class MyMainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyMainAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  State<MyMainAppBar> createState() => _MyMainAppBarState();
}

class _MyMainAppBarState extends State<MyMainAppBar> {
  @override
  Widget build(BuildContext context) {

    return PAppBar(title: '프로필',
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () async {
            final userPresenter = Get.find<UserPresenter>();
            if (await MySettingMain.toMySettingMain()) userPresenter.update();
          },
        ),
      ],
    );
  }
}


class MySettingMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MySettingMainAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return const PAppBar(title: '프로필',
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: GlobalPresenter.goBack,
      ),
    );
  }
}
