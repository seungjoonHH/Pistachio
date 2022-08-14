import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/firebase/login/login.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/function/dialog.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: PButton(
      //     onPressed: () => LoginPresenter.fwLogin(LoginType.google),
      //     text: '구글 계정으로 로그인',
      //   ),
      // ),
      body: Center(
        child: PIconButton(Icons.add,
          onPressed: () => showPDialog(
            title: '제목',
            content: PText('내용'),
            type: DialogType.none,
          ),
          backgroundColor: PTheme.primary,
          iconColor: PTheme.white,
        ),
      ),
    );
  }
}
