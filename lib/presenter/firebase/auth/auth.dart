import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/class/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/firebase/auth/apple.dart';
import 'package:pistachio/presenter/firebase/auth/google.dart';
import 'package:pistachio/presenter/firebase/firebase.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/presenter/page/home.dart';

class AuthPresenter {
  /// static methods
  // 로그인 형식에 따른 피트윈 로그인
  static Future pLogin(LoginType type) async {
    final userPresenter = Get.find<UserPresenter>();
    UserCredential? userCredential;

    // 신규회원 여부
    bool isNewcomer = false;

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
    Map<String, dynamic>? json = (await f
        .collection('users')
        .doc(userCredential.user!.uid)
        .get()
    ).data();

    // 파이어베이스에 문서가 없거나 json 데이터에 닉네임이 없을 경우 신규 회원
    isNewcomer = json == null || json['nickname'] == null;

    Map<String, dynamic> data = {};
    data['uid'] = userCredential.user!.uid;
    data['name'] = userCredential.user!.displayName;
    data['email'] = userCredential.user!.email;
    data['regDate'] = Timestamp.now();

    userPresenter.data = {...data};

    // 신규 회원일 경우
    if (isNewcomer) {
      // 회원가입 페이지로 이동
      Get.toNamed('/register');
    }

    // 기존 회원일 경우
    else {
      // 파이어베이스 데이터로 로그인
      PUser stranger = PUser.fromJson(json);
      userPresenter.login(stranger);
      HomePresenter.toHome();
    }
  }

  // 피트윈 로그아웃
  static void pLogout() {
    final userPresenter = Get.find<UserPresenter>();
    Get.offAllNamed('/login');
    userPresenter.logout();
  }

  // 피트윈 계정삭제
  static void pDeleteAccount() {
    final userPresenter = Get.find<UserPresenter>();
    userPresenter.delete();
    pLogout();
  }
}