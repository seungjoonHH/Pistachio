/* 사용자 모델 프리젠터 */

import 'dart:math';

import 'package:get/get.dart';
import 'package:pistachio/model/class/challenge.dart';
import 'package:pistachio/model/class/collection.dart';
import 'package:pistachio/model/class/party.dart';
import 'package:pistachio/model/class/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/firebase/firebase.dart';
import 'package:pistachio/presenter/model/challenge.dart';

import '../health/health.dart';

/// class
class UserPresenter extends GetxController {
  /// attributes
  /* 로그인 관련 */
  // User Credential 정보
  Map<String, dynamic> data = {};

  // 현재 로그인된 사용
  PUser loggedUser = PUser();

  // 로그인 여부
  bool get isLogged => loggedUser.uid != null;

  final notifications = <Map<String, dynamic>>[].obs;

  /// methods
  /* 로그인 관련 */
  // 로그인
  // 매개변수로 받은 사용자 정보와 User Credential 정보를 병합하여 현재 로그인된 사용자자 최신화
  Future login(PUser user) async {
    Map<String, dynamic> json = user.toJson();
    data.forEach((key, value) => json[key] = value);
    loggedUser = PUser.fromJson(json);
    await HealthPresenter.fetchStepData();
  }

  // 로그아웃
  // 현재 로그인된 사용자 정보 초기화
  void logout() {
    loggedUser = PUser();
  }

  /* 파이어베이스 관련 */
  // 파이어베이스에서 로드
  Future load() async {
    var json = (await f.collection('users').doc(loggedUser.uid).get()).data();
    if (json == null) return;
    loggedUser = PUser.fromJson(json);
  }

  // 파이어베이스에 최신화
  void save() =>
      f.collection('users').doc(loggedUser.uid).set(loggedUser.toJson());

  // 파이어베이스에서 삭제
  void delete() => f.collection('users').doc(loggedUser.uid).delete();

  Map<String, Party> get myParties => loggedUser.parties;
  set myParties(Map<String, Party> parties) => loggedUser.parties = parties;

  String get randomCode {
    int length = 7;
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(
        Random().nextInt(chars.length),
      )),
    );
  }

  Future getMembers(Party party) async {
    for (String uid in party.records.keys) {
      var json = (await f.collection('users').doc(uid).get()).data();

      if (json == null) return;
      PUser member = PUser.fromJson(json);
      party.members.add(member);
    }
  }


  void addMyParties(Challenge challenge, Difficulty diff) async {
    String code = randomCode;

    Party newParty = Party.fromJson({
      'id': code,
      'challengeId': challenge.id,
      'difficulty': diff.name,
      'records': <String, dynamic>{ loggedUser.uid!: 0 },
      'leaderUid': loggedUser.uid,
    });

    newParty.challenge = ChallengePresenter.getChallenge(newParty.challengeId!);
    myParties[code] = newParty;
    await getMembers(newParty);
    saveMyParty(newParty);

    loggedUser.partyIds.add(newParty.id!);
    save();

    update();
  }

  Future loadMyParties() async {
    for (String id in loggedUser.partyIds) {
      var json = (await f.collection('parties').doc(id).get()).data();
      if (json == null) return;
      Party party = Party.fromJson(json);
      party.challenge = ChallengePresenter.getChallenge(party.challengeId!);
      await getMembers(party);
      myParties[json['id']] = party;
    }
    update();
  }

  void saveMyParty(Party party) async {
    await f.collection('parties').doc(party.id).set(party.toJson());
  }

  set myCollections(List<Collection> collections) => loggedUser.collections = collections;
  List<Collection> get myCollections => loggedUser.collections;

  bool joining(Challenge challenge) {
    return myParties.values.map((party) => party.challengeId).contains(challenge.id);
  }

  Party? joiningParty(Challenge challenge) {
    return myParties.values.toList().firstWhereOrNull((party) => party.challengeId == challenge.id);
  }
}
