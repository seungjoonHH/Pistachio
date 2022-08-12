import 'package:flutter/material.dart';
import 'package:pistachio/presenter/firebase/login/login.dart';
import 'package:pistachio/view/widget/button/button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PButton(
          onPressed: () => LoginPresenter.fwLogin(LoginType.google),
          text: '구글 계정으로 로그인',
        ),
      ),
    );
  }
}
