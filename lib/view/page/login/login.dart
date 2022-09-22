import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/view/page/login/widget.dart';
import 'package:pistachio/view/widget/widget/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const backgroundAsset = 'assets/image/page/login/background.svg';

    return Scaffold(
      backgroundColor: PTheme.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: SvgPicture.asset(backgroundAsset)),
          const Positioned(top: 200.0, child: PLogo()),
          Positioned(
            bottom: 20.0,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInButton(type: LoginType.google),
                SizedBox(height: 15.0),
                SignInButton(type: LoginType.apple),
                /*if (Platform.isIOS) {
                  SignInButton(type: LoginType.apple),
                },*/
                SizedBox(height: 77.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// child: PButton(
//   onPressed: () => showPDialog(
//     title: '참여가 완료되었어요!',
//     content: PText('이제 메인 화면에서 달성률을 확인할 수 있어요.',
//       style: textTheme.bodyMedium,
//       maxLines: 2,
//       align: TextAlign.center,
//     ),
//     type: DialogType.mono,
//     onPressed: () {},
//     contentPadding: const EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 50.0),
//   ),
//   text: '구글 계정으로 로그인',
// ),
