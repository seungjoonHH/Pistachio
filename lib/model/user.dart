/* 사용자 모델 구조 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pistachio/global/date.dart';
import 'package:get/get.dart';

/// enums
// 성별 { 남성, 여성 }
enum Sex {
  male, female;
String get kr => ['남성', '여성'][index];
}

/// class
class PUser {
  /// static variables
  // 사용자의 기본 프로필 사진
  static const String defaultImageUrl = 'https://firebasestorage.googleapis.com/v0/b/fitween-v1-1.appspot.com/o/users%2Fguest.png?alt=media&token=d0c5908c-57a0-4d1d-9277-57c0cd23acd5';

  /// attributes
  // uid
  String? uid;

  // 이름
  String? name;

  // 닉네임
  String? nickname;

  // 상태메시지
  String? statusMessage;

  // 성별
  Sex? sex;

  // 가입일
  Timestamp? _regDate;

  // 생년월일
  Timestamp? _dateOfBirth;

  // 프로필 이미지 주소
  String? imageUrl;

  // 파티 아이디 리스트
  List<String> partyIds = [];

  // 컬렉션 아이디 리스트
  // 예시)
  // [
  //   {
  //     "date": 22-08-10,
  //     "collection": {
  //       "id": "1000000",
  //       "title": "22년 1월의 PIE",
  //       "imageUrl": null,
  //       "description": "2022년 1월에 받은 파이이다."
  //     }
  //   }
  // ]
  List<dynamic> collectionIds = [];

  // 하루 당 목표
  // 예시)
  // [
  //   { "type": "무게", "amount": 1000 },
  //   { "type": "거리", "amount": 1000 },
  //   { "type": "높이", "amount": 1000 }
  // ]
  List<dynamic> goals = [];

  // 누적기록
  // 예시)
  // [
  //   {
  //     "type": "무게",
  //     "recordList": [
  //       { "date": 22-08-10, "amount": 100 },
  //       { "date": 22-08-11, "amount": 120 }
  //     ]
  //   },
  //   {
  //     "type": "거리",
  //     "recordList": [
  //       { "date": 22-08-10, "amount": 100 },
  //       { "date": 22-08-11, "amount": 120 }
  //     ]
  //   },
  //   {
  //     "type": "높이",
  //     "recordList": [
  //       { "date": 22-08-10, "amount": 100 },
  //       { "date": 22-08-11, "amount": 120 }
  //     ]
  //   }
  // ]
  List<dynamic> records = [];


  /// accessors & mutators
  // 가입일 getter
  DateTime? get regDate => _regDate?.toDate();

  // 생년월일 getter
  DateTime? get dateOfBirth => _dateOfBirth?.toDate();

  // 가입일 setter
  set regDate(DateTime? date) => _regDate = toTimestamp(date);

  // 생년월일 setter
  set dateOfBirth(DateTime? date) => _dateOfBirth = toTimestamp(date);

  // 생년월일을 문자열 형태로 반환
  String? get dateOfBirthString => dateToString('yyyy-MM-dd', dateOfBirth);

  /// constructors
  // 기본 생성자
  PUser() {
    // 프로필 이미지 주소를 기본값으로 설정
    imageUrl = defaultImageUrl;
  }

  // json 데이터를 통해 객체를 생성하는 생성자
  PUser.fromJson(Map<String, dynamic> json) {
    fromJson(json);

    // json 데이터에 프로필 이미지 주소가 없을 경우 기본값으로 설정
    imageUrl ??= defaultImageUrl;
  }

  /// methods
  // json 데이터에 시작일 및 종료일 정보가 없을 경우 오늘 날짜 지정
  void fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    nickname = json['nickname'];
    statusMessage = json['statusMessage'];
    sex = toSex(json['sex']);
    _regDate = json['regDate'];
    _dateOfBirth = json['dateOfBirth'];
    imageUrl = json['imageUrl'];
    partyIds = (json['partyIds'] ?? []).cast<String>();
    collectionIds = (json['collectionIds'] ?? []).cast<String>();
    goals = json['goals'];
    records = json['records'];
  }

  // 객체의 json 데이터 추출
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['uid'] = uid;
    json['name'] = name;
    json['nickname'] = nickname;
    json['statusMessage'] = statusMessage;
    json['sex'] = sex?.name;
    json['regDate'] = _regDate;
    json['dateOfBirth'] = _dateOfBirth;
    json['imageUrl'] = imageUrl;
    json['partyIds'] = partyIds;
    json['collectionIds'] = collectionIds;
    json['goals'] = goals;
    json['records'] = records;
    return json;
  }

  // 문자열을 성별 enum 으로 전환 ('male' => Sex.male)
  static Sex? toSex(String? string) => Sex.values.firstWhereOrNull(
        (sex) => sex.name == string,
  );
}