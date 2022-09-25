
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/my/setting/edit.dart';
import 'package:pistachio/presenter/page/my/setting/main.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/badge.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class MySettingMainView extends StatelessWidget {
  const MySettingMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          MyProfileImageButton(),
          EditFieldView(),
          AccountButtonView(),
        ],
      ),
    );
  }
}

class MyProfileImageButton extends StatelessWidget {
  const MyProfileImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BadgeWidget(size: 120.0),
        const SizedBox(height: 10.0),
        PTextButton(
          text: '뱃지 변경',
          onPressed: () {},
          action: const Icon(Icons.add_photo_alternate_outlined),
        ),
      ],
    );
  }
}

class EditFieldView extends StatelessWidget {
  const EditFieldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        EditTextField(editType: 'nickname'),
        SizedBox(height: 10.0),
        EditTextField(editType: 'height'),
        SizedBox(height: 10.0),
        EditTextField(editType: 'weight'),
      ],
    );
  }
}


class EditTextField extends StatelessWidget {
  const EditTextField({Key? key, required this.editType}) : super(key: key);

  final String editType;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPresenter>(
      builder: (controller) {
        Map<String, String> kr = {
          'nickname': '별명',
          'height': '신장',
          'weight': '체중',
        };
        Map<String, String> value = {
          'nickname': controller.loggedUser.nickname!,
          'height': '${controller.loggedUser.height} cm',
          'weight': '${controller.loggedUser.weight} kg',
        };

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PText(kr[editType]!, style: textTheme.headlineSmall),
            const SizedBox(height: 10.0),
            Material(
              color: PTheme.white,
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: () => MySettingEdit.toMySettingEdit(editType),
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: PTheme.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: PText(value[editType]!,
                    style: textTheme.titleMedium,
                    color: PTheme.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AccountButtonView extends StatelessWidget {
  const AccountButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        LogoutButton(),
        SizedBox(height: 10.0),
        AccountDeleteButton(),
      ],
    );
  }
}


class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PButton(
      text: '로그아웃',
      onPressed: MySettingMain.logoutButtonPressed,
      fill: false,
      stretch: true,
    );
  }
}

class AccountDeleteButton extends StatelessWidget {
  const AccountDeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PButton(
      text: '계정 삭제하기',
      onPressed: MySettingMain.accountDeleteButtonPressed,
      stretch: true,
      backgroundColor: Colors.red,
    );
  }
}