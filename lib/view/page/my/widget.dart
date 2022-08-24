/* 마이 페이지 위젯 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyView extends StatelessWidget {
  const MyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: const [
          /*
          ProfileImageButton(user: userPresenter.loggedUser),
          const SizedBox(height: 10.0),
          Column(
            children: [
              FWText(userPresenter.loggedUser.nickname!,
                style: textTheme.titleLarge,
              ),
              FWText(userPresenter.loggedUser.statusMessage ?? '',
                style: textTheme.bodyMedium,
              ),
            ],
          ),*/
          MyProfileImage(),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leadingWidth: 600.0,
      actions: const [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.black
          ),
            onPressed: null
          //onPressed: SettingPresenter.toSetting,
        ),
      ],
    );
  }
}

class MyProfileImage extends StatelessWidget {
  const MyProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPresenter>(
      builder: (controller) {
        return Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 11.0),
                  child: Container(
                    width: 64.0,
                    height: 64.0,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: PTheme.black.withOpacity(.1),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          /*child: CircleAvatar(
                            backgroundImage: NetworkImage(controller.loggedUser.imageUrl!),
                          ),*/
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.loggedUser.nickname!,
                      style: textTheme.headlineMedium,
                    ),
                    Text(controller.loggedUser.height.toString(),
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ]
        );
      },
    );
  }
}