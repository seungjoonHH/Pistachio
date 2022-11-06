import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/firebase/auth/apple.dart';
import 'package:pistachio/presenter/firebase/auth/google.dart';
import 'package:pistachio/presenter/firebase/firebase.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/home.dart';
import 'package:pistachio/presenter/page/onboarding.dart';

class AuthPresenter {
  static const storage = FlutterSecureStorage();
  static String? appleName;

  /// static methods
  // 로그인 형식에 따른 피트윈 로그인
  static Future pLogin(LoginType type) async {
    final userP = Get.find<UserPresenter>();

    UserCredential? userCredential;
    Map<String, dynamic>? json;

    // 로그인 형식에 따른 로그인 방식
    switch (type) {
      case LoginType.google:
        userCredential = await GoogleAuth.signInWithGoogle();
        break;
      case LoginType.apple:
        userCredential = await AppleAuth.signInWithApple();
        break;
    }

    if (userCredential == null) return;

    // 파이어베이스 데이터
    json = (await f.collection('users').doc(userCredential.user!.uid).get()).data();

    // 파이어베이스에 문서가 없거나 json 데이터에 닉네임이 없을 경우 신규 회원
    bool isNewcomer = json == null || json['nickname'] == null;

    Map<String, dynamic> data = {};
    data['uid'] = userCredential.user!.uid;
    data['name'] = userCredential.user!.displayName ?? appleName;
    data['email'] = userCredential.user!.email;

    userP.data = {...data};

    // 신규 회원일 경우
    if (isNewcomer) {
      // 회원가입 페이지로 이동
      OnboardingPresenter.toOnboarding();
    }

    // 기존 회원일 경우
    else {
      // 파이어베이스 데이터로 로그인
      PUser stranger = PUser.fromJson(json);
      await userP.login(stranger);
      await storeLoginData(userP.data);
      await HomePresenter.toHome();
    }
  }

  // 피트윈 로그아웃
  static void pLogout() {
    final userP = Get.find<UserPresenter>();
    Get.offAllNamed('/login');
    userP.logout();
    eliminateLoginData(userP.data);
  }

  // 피트윈 계정삭제
  static void pDeleteAccount() {
    final userP = Get.find<UserPresenter>();
    userP.delete();
    pLogout();
  }

  static void loadLoginData() async {
    final userP = Get.find<UserPresenter>();

    String? userInfo = await storage.read(key: 'login');
    bool beenLogged = userInfo != null;

    // 자동 로그인
    if (!beenLogged) return;

    userP.data = jsonDecode(userInfo);
    userP.loggedUser.uid = userP.data['uid'];
    await userP.load();
    HomePresenter.toHome();
  }

  // 로그인 데이터 전송
  static Future storeLoginData(Map<String, dynamic> data) async {
    await storage.write(
      key: 'login',
      value: jsonEncode(data),
    );
  }

  // 로그인 데이터 삭제
  static Future eliminateLoginData(Map<String, dynamic> data) async {
    await storage.delete(key: 'login');
  }
}
