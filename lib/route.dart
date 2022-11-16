/* 라우트 관련 */
import 'package:pistachio/view/page/challenge/create/create.dart';
import 'package:pistachio/view/page/challenge/main/main.dart';
import 'package:pistachio/view/page/challenge/detail/detail.dart';
import 'package:pistachio/view/page/challenge/complete/complete.dart';
import 'package:pistachio/view/page/challenge/party/party.dart';
import 'package:pistachio/view/page/collection/main/main.dart';
import 'package:pistachio/view/page/developer_info/main.dart';
import 'package:pistachio/view/page/edit_goal/edit_goal.dart';
import 'package:pistachio/view/page/exercise/input/input.dart';
import 'package:pistachio/view/page/home/home.dart';
import 'package:pistachio/view/page/login/login.dart';
import 'package:pistachio/view/page/my/record/record.dart';
import 'package:pistachio/view/page/my/setting/edit/edit.dart';
import 'package:pistachio/view/page/my/setting/main/main.dart';
import 'package:pistachio/view/page/onboarding/onboarding.dart';
import 'package:pistachio/view/page/quest/quest.dart';
import 'package:pistachio/view/page/record/detail/detail.dart';
import 'package:pistachio/view/page/record/main/main.dart';
import 'package:pistachio/view/page/register/register.dart';
import 'package:pistachio/view/page/my/main/my.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/view/page/release_note/main.dart';

/// class
class PRoute {
  /// static variables
// 화면 전환 트랜지션
  static const Transition transition = Transition.fadeIn;

// 화면 전환 지속시간
  static const Duration duration = Duration(milliseconds: 100);

  /// static methods
// 라우트 문자열, 페이지 매핑
  static Map<String, Widget> get pages =>
      {
        '/home': const HomePage(),
        '/login': const LoginPage(),
        '/register': const RegisterPage(),
        '/onboarding': const OnboardingPage(),
        '/exercise/input': const ExerciseInputPage(),
        '/record/main': const RecordMainPage(),
        '/record/detail': const RecordDetailPage(),
        '/challenge/main': const ChallengeMainPage(),
        '/challenge/detail': const ChallengeDetailPage(),
        '/challenge/create': const ChallengeCreatePage(),
        '/challenge/party/complete': const ChallengePartyCompletePage(),
        '/challenge/party/main': const ChallengePartyMainPage(),
        '/collection/main': const CollectionMainPage(),
        '/my/main': const MyMainPage(),
        '/my/record/main': const MyRecordMainPage(),
        '/my/setting/main': const MySettingMainPage(),
        '/my/setting/edit': const MySettingEditPage(),
        '/quest': const QuestPage(),
        '/editGoal': const EditGoalPage(),
        '/releaseNote': const ReleaseNotePage(),
        '/developerInfo': const DeveloperInfoPage(),
      };

  // 겟페이지 리스트
  static List<GetPage> get getPages =>
      pages.entries
          .map((page) =>
          GetPage(
            name: page.key,
            page: () => page.value,
            transition: transition,
            transitionDuration: duration,
          ))
          .toList();
}
