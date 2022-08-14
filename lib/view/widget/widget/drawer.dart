import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/page/home.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:flutter/material.dart';

class HomeDrawerTile extends StatelessWidget {
  const HomeDrawerTile({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(iconData,
        color: PTheme.white,
      ),
      title: PText(text,
        style: textTheme.bodyLarge,
        color: PTheme.white,
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget{
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170.0,
      child: Drawer(
        backgroundColor: PTheme.secondary[40]!.withOpacity(.94),
        child: ListView(
          padding: const EdgeInsets.only(top: 100.0),
          children: [
            const HomeDrawerTile(
              onPressed: HomePresenter.toHome,
              iconData: Icons.home_outlined,
              text: '홈',
            ),
            const HomeDrawerTile(
              onPressed: ChallengePresenter.toChallengeMain,
              iconData: Icons.people_alt_outlined,
              text: '챌린지',
            ),
            HomeDrawerTile(
              onPressed: Get.back,
              iconData: Icons.book_outlined,
              text: '크루',
            ),
            HomeDrawerTile(
              onPressed: Get.back,
              iconData: Icons.dialpad,
              text: '컬렉션',
            ),
            HomeDrawerTile(
              onPressed: Get.back,
              iconData: Icons.settings,
              text: '설정',
            ),
          ],
        ),
      ),
    );
  }
}