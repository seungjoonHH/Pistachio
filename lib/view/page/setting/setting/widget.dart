/* 설정 페이지 위젯 */

import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/setting/edit_nickname.dart';
import 'package:pistachio/presenter/page/setting/edit_height.dart';
import 'package:pistachio/presenter/page/setting/edit_weight.dart';
import 'package:pistachio/presenter/page/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}

class MyProfileImageButton extends StatelessWidget {
  const MyProfileImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userPresenter = Get.find<UserPresenter>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                  /*
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(userPresenter.loggedUser.imageUrl!),
                  ),*/
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(24.0, 0, 0, 0),
          child: TextButton.icon(
            onPressed: SettingPresenter.imageEditButtonPressed,
            label: const Icon(Icons.arrow_forward_ios, size: 24),
            icon: Text('뱃지 변경', style: textTheme.labelLarge),
          ),
        )
      ],
    );
  }
}

class NameTextField extends StatelessWidget {
  const NameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
      builder: (controller) {
        final userPresenter = Get.find<UserPresenter>();
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
                    child: Text('이름',
                      style: textTheme.headlineSmall,
                    ),
                  ),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      primary: Colors.white,
                      side: BorderSide(width: 1.0, color: colorScheme.outline),
                    ),
                    onPressed: EditNicknamePresenter.toEditNickname,
                    child: Stack(
                      children: [
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.keyboard_arrow_right_outlined)
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            userPresenter.loggedUser.nickname!,
                            style: textTheme.labelLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class HeightTextField extends StatelessWidget {
  const HeightTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
      builder: (controller) {
        final userPresenter = Get.find<UserPresenter>();
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
                    child: Text('신장',
                      style: textTheme.headlineSmall,
                    ),
                  ),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      primary: Colors.white,
                      side: BorderSide(width: 1.0, color: colorScheme.outline),
                    ),
                    onPressed: EditHeightPresenter.toEditHeight,
                    child: Stack(
                      children: [
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.keyboard_arrow_right_outlined)
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            userPresenter.loggedUser.height.toString(),
                            style: textTheme.labelLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class WeightTextField extends StatelessWidget {
  const WeightTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
      builder: (controller) {
        final userPresenter = Get.find<UserPresenter>();
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
                    child: Text('체중',
                      style: textTheme.headlineSmall,
                    ),
                  ),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      primary: Colors.white,
                      side: BorderSide(width: 1.0, color: colorScheme.outline),
                    ),
                    onPressed: EditWeightPresenter.toEditWeight,
                    child: Stack(
                      children: [
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.keyboard_arrow_right_outlined)
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            userPresenter.loggedUser.weight.toString(),
                            style: textTheme.labelLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
      builder: (controller) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 10.0),
              width: 343.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  primary: Colors.white,
                  side: BorderSide(
                    width: 1.0,
                    color: colorScheme.outline,
                  ),
                ),
                onPressed: SettingPresenter.logoutButtonPressed,
                child: const Text('로그아웃',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DeleteUserButton extends StatelessWidget {
  const DeleteUserButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
      builder: (controller) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
              width: 343.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  primary: colorScheme.error,
                ),
                onPressed: SettingPresenter.showDeleteAccountConfirmDialog,
                child: const Text('계정 삭제하기',
                  style: TextStyle(color: PTheme.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}