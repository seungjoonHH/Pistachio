
import 'package:get/get.dart';
import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/presenter/firebase/firebase.dart';
import 'package:pistachio/presenter/model/user.dart';

class PartyPresenter extends GetxController {
  final userPresenter = Get.find<UserPresenter>();

  List<Party> parties = [];

  Future loadAll() async {
    parties.clear();
    for (var doc in (await f.collection('parties').get()).docs) {
      parties.add(Party.fromJson(doc.data()));
    }
  }

  static Future<bool> partyExists(String id) async {
    if (id == '') return false;
    return (await f.collection('parties').doc(id).get()).exists;
  }

  static Future loadMembers(Party party) async {
    List<PUser> members = [];

    for (var uid in party.records.keys) {
      var json = (await f.collection('users').doc(uid).get()).data();
      if (json == null) continue;
      members.add(PUser.fromJson(json));
    }
    party.members = [...members];
  }

  static Future<Party?> loadParty(String id) async {
    var json = (await f.collection('parties').doc(id).get()).data();
    if (json == null) return null;
    return Party.fromJson(json);
  }

  static void save(Party party) {
    f.collection('parties').doc(party.id).set(party.toJson());
  }
}