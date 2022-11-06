import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/main.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/view/page/login/widget.dart';
import 'package:pistachio/view/widget/widget/logo.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double backgroundOpacity;
  late double buttonsOpacity;

  @override
  void initState() {
    backgroundOpacity = .0;
    buttonsOpacity = .0;
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => backgroundOpacity = 1.0);
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() => buttonsOpacity = 1.0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    const backgroundAsset = 'assets/image/page/login/background.svg';

    return Scaffold(
      backgroundColor: PTheme.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: screenSize.aspectRatio,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              opacity: backgroundOpacity,
              child: SvgPicture.asset(backgroundAsset, fit: BoxFit.fill),
            ),
          ),
          const Positioned(top: 200.0, child: PLogo()),
          Positioned(
            bottom: 20.0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              opacity: buttonsOpacity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SignInButton(type: LoginType.google),
                  const SizedBox(height: 15.0),
                  //SignInButton(type: LoginType.apple),
                  if (Platform.isIOS)
                  const SignInButton(type: LoginType.apple),
                  const SizedBox(height: 77.0),
                ],
              ),
            ),
          ),
          Positioned(
            right: 25.0.w,
            bottom: 15.0.h,
            child: PText(version, color: PTheme.grey),
          ),
        ],
      ),
    );
  }
}