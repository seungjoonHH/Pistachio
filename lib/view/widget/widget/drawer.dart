import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget{
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(top:80),
          color: const Color(0xff54BAB9),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(top:15,bottom:15),
                child: ListTile(
                  leading: const Icon(Icons.people_alt_outlined,
                    color: PTheme.white,
                  ),
                  title: PText('챌린지',
                    style: textTheme.bodyLarge,
                    color: PTheme.white,
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top:15,bottom:15),
                child: ListTile(
                  leading: const Icon(Icons.book_outlined,
                    color: PTheme.white,
                  ),
                  title: PText('크루',
                    style: textTheme.bodyLarge,
                    color: PTheme.white,
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top:15,bottom:15),
                child: ListTile(
                  leading: const Icon(Icons.dialpad,
                    color: PTheme.white,
                  ),
                  title: PText('컬렉션',
                    style: textTheme.bodyLarge,
                    color: PTheme.white,
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top:15,bottom:15),
                child: ListTile(
                  leading: const Icon(Icons.settings,
                    color: PTheme.white,
                  ),
                  title: PText('설정',
                    style: textTheme.bodyLarge,
                    color: PTheme.white,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}