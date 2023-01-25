/* 사용자 모델 프리젠터 */
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/model/class/json/badge.dart';
import 'package:pistachio/model/class/json/challenge.dart';
import 'package:pistachio/model/class/database/collection.dart';
import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/enum/activity_type.dart';
import 'package:pistachio/model/enum/difficulty.dart';
import 'package:pistachio/model/enum/unit.dart';
import 'package:pistachio/presenter/firebase/firebase.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/health/health.dart';
import 'package:pistachio/presenter/model/badge.dart';
import 'package:pistachio/presenter/model/party.dart';
import 'package:pistachio/presenter/model/record.dart';

/// class
// 사용자 객체 관련
class UserPresenter extends GetxController {
  /// static variables

  /// static methods
  static Future<PUser?> loadUser(String uid) async {
    var json = (await f.collection('users').doc(uid).get()).data();
    if (json == null) return null;
    return PUser.fromJson(json);
  }

  static void saveUser(PUser user) async {
    f.collection('users').doc(user.uid).set(user.toJson());
  }

  /// attributes
  /* 로그인 관련 */
  // User Credential 정보
  Map<String, dynamic> data = {};

  // 현재 로그인된 사용자
  PUser loggedUser = PUser();

  // 로그인 여부
  bool get isLogged => loggedUser.uid != null;

  /// methods
  /* 로그인 관련 */
  // 로그인
  // 매개변수로 받은 사용자 정보와 User Credential 정보를 병합하여 현재 로그인된 사용자자 최신화
  Future login(PUser user) async {
    Map<String, dynamic> json = user.toJson();
    data.forEach((key, value) => json[key] = value);
    loggedUser = PUser.fromJson(json);
    await fetchData();
  }

  // 로그아웃
  // 현재 로그인된 사용자 정보 초기화
  void logout() => loggedUser = PUser();

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
  void delete() {
    PartyPresenter.deleteMember(loggedUser.uid!);
    f.collection('users').doc(loggedUser.uid).delete();
  }

  // 챌린지와 난이도에 따른 새로운 파티 생성, 해당 파티 코드 반환
  // 로그인된 사용자가 직접 파티를 생성하는 경우
  Future<String> createMyParty(Challenge challenge, Difficulty diff) async {
    String code = PUser.randomCode;

    Party newParty = Party.fromJson({
      'id': code,
      'complete': false,
      'challengeId': challenge.id,
      'difficulty': diff.name,
      'records': <String, dynamic>{loggedUser.uid!: 0},
      'leaderUid': loggedUser.uid,
    });

    loggedUser.parties[code] = newParty;
    await PartyPresenter.loadMembers(newParty);
    PartyPresenter.save(newParty);

    loggedUser.partyIds.add(newParty.id!);
    save();

    update();

    return code;
  }

  // 파이어베이스에서 나의 파티 리스트 로드
  Future loadMyParties() async {
    for (String id in loggedUser.partyIds) {
      var json = (await f.collection('parties').doc(id).get()).data();
      if (json == null) return;
      Party party = Party.fromJson(json);
      await PartyPresenter.loadMembers(party);
      loggedUser.parties[json['id']] = party;
    }
    update();
  }

  // 해당 아이디의 파티에 참가
  // 로그인된 사용자가 직접 참가하는 경우
  void joinParty(String id) {
    if (loggedUser.partyIds.contains(id)) return;
    loggedUser.partyIds.add(id);
    save();
  }

  // 로그인된 사용자가 해당 아이디의 챌린지에 이미 참여 중인지 여부 반환
  bool alreadyJoinedChallenge(String challengeId) {
    return loggedUser.parties.values
        .map((party) => party.challengeId)
        .contains(challengeId);
  }

  // 로그인된 사용자가 해당 코드의 파티에 이미 참여 중인지 여부 반환
  bool alreadyJoinedParty(String code) {
    return loggedUser.parties.values.map((party) => party.id).contains(code);
  }

  // 로그인된 사용자가 해당 아이디의 파티가 있을 경우 파티 객체 반환
  // 그렇지 않은 경우 null 반환
  Party? getPartyByChallengeId(String challengeId) {
    return loggedUser.parties.values
        .toList()
        .firstWhereOrNull((party) => party.challengeId == challengeId);
  }

  /* 기록 관련 */
  // 건강 및 구글핏 데이터 불러오기
  Future fetchData() async {
    bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    await HealthPresenter.requestAuth();
    await HealthPresenter.fetchStepData();
    if (isIOS) await HealthPresenter.fetchFlightsData();
    updateCalorie();
  }

  // 로그인된 사용자의 거리 및 높이 기록에 따른 칼로리 소모량을 계산하여 최신화
  void updateCalorie() async {
    DistanceRecord distance = DistanceRecord(
      amount: loggedUser.getAmounts(
        ActivityType.distance,
        today,
        oneSecondBefore(tomorrow),
      ),
      state: ExerciseUnit.step,
    );

    HeightRecord height = HeightRecord(
      amount: loggedUser.getAmounts(
        ActivityType.height,
        today,
        oneSecondBefore(tomorrow),
      ),
    );

    WeightRecord weight = WeightRecord(
      amount: loggedUser.getAmounts(
        ActivityType.weight,
        today,
        oneSecondBefore(tomorrow),
      ),
      state: ExerciseUnit.count,
    );

    CalorieRecord calorie = CalorieRecord(amount: 0);

    calorie.amount += CalorieRecord.from(
      ActivityType.distance,
      distance.minute,
    );
    calorie.amount += CalorieRecord.from(
      ActivityType.height,
      height.amount,
    );
    calorie.amount += CalorieRecord.from(
      ActivityType.weight,
      weight.amount,
    );

    loggedUser.setRecord(
      ActivityType.calorie,
      today, calorie,
    );

    save();
    update();
  }

  void clearRecords() {
    for (ActivityType type in ActivityType.values) {
      ExerciseUnit? unit;

      switch (type) {
        case ActivityType.distance:
          unit = ExerciseUnit.step;
          break;
        case ActivityType.weight:
          unit = ExerciseUnit.count;
          break;
        default: break;
      }
      print(type);
      Record record = Record.init(type, 0, unit);
      loggedUser.setRecord(type, today, record);
    }
  }

  // 해당 활동형식의 기록 추가 (구글핏/건강 연동, 칼로리 계산, 관련 뱃지 수여)
  void addRecord(
    ActivityType type,
    Record record,
  ) async {
    bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    late int before, after;

    before = loggedUser.completedActivities.length;

    loggedUser.addRecord(type, today, record, true);
    updateCalorie();

    // switch (type) {
    //   case ActivityType.distance:
    //     if (!isIOS) record.amount += loggedUser.getTodayAmounts(type);
    //     await HealthPresenter.addStepsData(record);
    //     break;
    //   case ActivityType.height:
    //     if (!isIOS) break;
    //     await HealthPresenter.addFlightsData(record);
    //     break;
    //   default: break;
    // }

    after = loggedUser.completedActivities.length;

    if (before != 3 && after == 3) {
      BadgePresenter.awardDailyActivityCompleteBadge();
    }
    save();
  }

  // 해당 활동형식의 기록 설정
  void setRecord(ActivityType type, Record record) async {
    late int before, after;

    before = loggedUser.completedActivities.length;

    loggedUser.setRecord(type, today, record);
    updateCalorie();

    after = loggedUser.completedActivities.length;

    if (before != 3 && after == 3) {
      BadgePresenter.awardDailyActivityCompleteBadge();
    }
    save();
  }

  void setMainBadge(String badgeId, [bool showDialog = true]) {
    loggedUser.badgeId = badgeId;
    if (showDialog) GlobalPresenter.showCollectionSettingDialog(badgeId);
    save();
    update();
  }

  // 로그인된 사용자에게 뱃지 수여
  void awardBadge(
    PBadge badge, [
      bool once = false,
      bool aDay = false,
    ]
  ) async {
    assert(once || !aDay);

    for (Collection collection in loggedUser.collections) {
      if (collection.badgeId != badge.id) continue;

      bool awarded = collection.dates.isNotEmpty;
      bool awardedToday = collection.dates
          .map((date) => ignoreTime(date!)).contains(today);

      if (once) {
        if (aDay && awardedToday) return;
        if (!aDay && awarded) return;
      }

      GlobalPresenter.showAwardedBadgeDialog(badge);
      collection.addDate(now);
      return;
    }

    GlobalPresenter.showAwardedBadgeDialog(badge, true);
    if (badge.id == '1000000') setMainBadge(badge.id!, false);
    if (badge.id == '1999999') setMainBadge(badge.id!, false);

    loggedUser.collections.add(Collection.fromJson({
      'badgeId': badge.id,
      'dates': [toTimestamp(now)],
    }));

    save();
    update();
  }
}
