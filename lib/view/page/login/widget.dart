import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/firebase/auth/auth.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/widget/text.dart';

// 로그인 페이지 관련 위젯 모음

// 로그인 버튼
class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.type,
  }) : super(key: key);

  final LoginType type;

  @override
  Widget build(BuildContext context) {
    const Map<LoginType, Color> backgroundColors = {
      LoginType.google: PTheme.white,
      LoginType.apple: PTheme.black,
    };
    const Map<LoginType, Color> textColors = {
      LoginType.google: PTheme.black,
      LoginType.apple: PTheme.white,
    };

    return PButton(
      onPressed: () => AuthPresenter.pLogin(type),
      backgroundColor: backgroundColors[type],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/image/logo/${type.name}.svg',
            width: 23.0,
            height: 23.0,
          ),
          Container(
            width: 170.0,
            padding: const EdgeInsets.only(left: 20.0),
            child: PText(
              'Continue with ${toBeginningOfSentenceCase(type.name)}',
              style: textTheme.bodyMedium,
              color: textColors[type],
            ),
          ),
        ],
      ),
    );
  }
}