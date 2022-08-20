/* 라우트 관련 */
import 'package:pistachio/view/page/challenge/main/main.dart';
import 'package:pistachio/view/page/challenge/detail/detail.dart';
import 'package:pistachio/view/page/challenge/difficulty/difficulty.dart';
import 'package:pistachio/view/page/challenge/complete/complete.dart';
import 'package:pistachio/view/page/exercise/complete/complete.dart';
import 'package:pistachio/view/page/exercise/main/main.dart';
import 'package:pistachio/view/page/exercise/setting/detail/detail.dart';
import 'package:pistachio/view/page/exercise/setting/type/type.dart';
import 'package:pistachio/view/page/home/home.dart';
import 'package:pistachio/view/page/login/login.dart';
import 'package:pistachio/view/page/monthlyQuest/monthlyQuest.dart';
import 'package:pistachio/view/page/record/detail/detail.dart';
import 'package:pistachio/view/page/record/main/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/view/page/register/register.dart';

/// class
class PRoute {
  /// static variables
// 화면 전환 트랜지션
  static const Transition transition = Transition.fadeIn;

// 화면 전환 지속시간
  static const Duration duration = Duration(milliseconds: 100);

  /// static methods
// 라우트 문자열, 페이지 매핑
  static Map<String, Widget> get pages => {
        '/home': const HomePage(),
        '/login': const LoginPage(),
        '/register': const RegisterPage(),
        '/exercise/main': const ExerciseMainPage(),
        '/exercise/complete': const ExerciseCompletePage(),
        '/exercise/setting/type': const ExerciseTypeSettingPage(),
        '/exercise/setting/detail': const ExerciseDetailSettingPage(),
        '/record/main': const RecordMainPage(),
        '/record/detail': const RecordDetailPage(),
        '/challenge/main': const ChallengeMainPage(),
        '/challenge/detail': const ChallengeDetailPage(),
        '/challenge/difficulty': const ChallengeDifficultyPage(),
        '/challenge/complete': const ChallengeCompletePage(),
        '/monthlyQuest': const MonthlyQuestPage(),
      };

  // 겟페이지 리스트
  static List<GetPage> get getPages => pages.entries
      .map((page) => GetPage(
            name: page.key,
            page: () => page.value,
            transition: transition,
            transitionDuration: duration,
          ))
      .toList();
}
