
import 'package:get/get.dart';
import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/presenter/firebase/firebase.dart';
import 'package:pistachio/presenter/model/user.dart';

/// class
// 파이어베이스 파티 관련
class PartyPresenter extends GetxController {
  final userP = Get.find<UserPresenter>();

  List<Party> parties = [];

  // 파이어베이스에 해당 아이디의 파티 존재 여부 반환
  static Future<bool> partyExists(String id) async {
    if (id == '') return false;
    return (await f.collection('parties').doc(id).get()).exists;
  }

  // 파이어베이스에서 전체 파티 리스트 로드
  Future loadAll() async {
    parties.clear();
    for (var doc in (await f.collection('parties').get()).docs) {
      parties.add(Party.fromJson(doc.data()));
    }
  }

  // 파이어베이스에서 해당 아이디의 파티를 로드
  static Future<Party?> loadParty(String id) async {
    var json = (await f.collection('parties').doc(id).get()).data();
    if (json == null) return null;
    return Party.fromJson(json);
  }

  // 파이어베이스에서 해당 파티의 멤버 리스트를 로드
  static Future loadMembers(Party party) async {
    List<PUser> members = [];

    for (var uid in party.records.keys) {
      var json = (await f.collection('users').doc(uid).get()).data();
      if (json == null) continue;
      members.add(PUser.fromJson(json));
    }
    party.members = [...members];
  }

  // 파이어베이스에 해당 파티를 최신화
  static void save(Party party) {
    f.collection('parties').doc(party.id).set(party.toJson());
  }
}