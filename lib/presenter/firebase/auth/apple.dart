/* 구글 로그인 관련 프리젠터 */
import 'dart:io';
// Needed because we can't import `dart:html` into a mobile app,
// while on the flip-side access to `dart:io` throws at runtime (hence the `kIsWeb` check below)

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId:
        'com.fitween.pistachio',

        redirectUri:
        // For web your redirect URI needs to be the host of the "current page",
        // while for Android you will be using the API server that redirects back into your app via a deep link
        kIsWeb
            ? Uri.parse('pistachio-8c35b.firebaseapp.com')
            : Uri.parse(
          'https://pistachio-8c35b.firebaseapp.com/callback.apple',
        ),
      ),
    );

    // ignore: avoid_print
    print(credential);

    // This is the endpoint that will convert an authorization code obtained
    // via Sign in with Apple into a session in your system
    final signInWithAppleEndpoint = Uri(
      scheme: 'https',
      host: 'pistachio-8c35b.firebaseapp.com',
      path: '/sign_in_with_apple',
      queryParameters: <String, String>{
        'code': credential.authorizationCode,
        if (credential.givenName != null)
          'firstName': credential.givenName!,
        if (credential.familyName != null)
          'lastName': credential.familyName!,
        'useBundleId':
        !kIsWeb && (Platform.isIOS || Platform.isMacOS)
            ? 'true'
            : 'false',
        if (credential.state != null) 'state': credential.state!,
      },
    );

    final session = await http.Client().post(
      signInWithAppleEndpoint,
    );

    // If we got this far, a session based on the Apple ID credential has been created in your system,
    // and you can now set this as the app's session
    // ignore: avoid_print
    print(session);

    return null;
  }

  // 애플 로그아웃
  static void signOutWithApple() => a.signOut();
}