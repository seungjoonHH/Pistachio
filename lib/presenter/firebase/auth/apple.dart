/* 구글 로그인 관련 프리젠터 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pistachio/presenter/firebase/firebase.dart';

/// class
class AppleAuth {
  // 애플 로그인
  static Future<UserCredential?> signInWithApple() async {
    /// not implemented
    return null;
  }

  // 애플 로그아웃
  static void signOutWithApple() => a.signOut();
}