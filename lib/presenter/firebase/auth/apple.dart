/* 구글 로그인 관련 프리젠터 */
// Needed because we can't import `dart:html` into a mobile app,
// while on the flip-side access to `dart:io` throws at runtime (hence the `kIsWeb` check below)
//import 'html_shim.dart' if (dart.library.html) 'dart:html' show window;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pistachio/presenter/firebase/firebase.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// class
class AppleAuth {
  // 애플 로그인
  static Future<UserCredential?> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );

    return await a.signInWithCredential(oauthCredential);
  }

  // 애플 로그아웃
  static void signOutWithApple() => a.signOut();
}