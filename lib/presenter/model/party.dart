
import 'package:get/get.dart';
import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/presenter/model/user.dart';

class PartyPresenter extends GetxController {
  final userPresenter = Get.find<UserPresenter>();

  List<Party> parties = [];

}