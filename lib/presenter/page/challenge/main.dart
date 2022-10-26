import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/string.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/model/class/database/user.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/model/party.dart';
import 'package:pistachio/presenter/page/challenge/party/main.dart';
import 'package:pistachio/presenter/widget/loading.dart';
import 'package:pistachio/presenter/model/challenge.dart';
import 'package:pistachio/presenter/model/user.dart';
import 'package:pistachio/view/widget/function/dialog.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class ChallengeMain extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<Widget> tabs = ['이달의 챌린지', '내 챌린지']
      .map((title) => PText(title)).toList();

  late TabController tabCont;
  final codeCont = TextEditingController();
  bool codeInvalid = false;
  String? codeHintText = '';

  static void toChallengeMain() async {
    final loadingPresenter = Get.find<LoadingPresenter>();
    final userPresenter = Get.find<UserPresenter>();
    final challengeMain = Get.find<ChallengeMain>();

    loadingPresenter.loadStart();

    challengeMain.tabCont.index = 0;
    Get.offAllNamed('/challenge/main');
    await ChallengePresenter.importFile();
    await userPresenter.load();
    await userPresenter.loadMyParties();

    loadingPresenter.loadEnd();
  }

  void challengeJoinButtonPressed() async {
    codeCont.clear();
    codeHintText = null;

    Get.dialog(
      PAlertDialog(
        title: '코드 입력',
        content: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0, vertical: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PText('참여할 챌린지 코드를 입력하세요'),
              SizedBox(height: 10.0.h),
              GetBuilder<ChallengeMain>(
                builder: (controller) {
                  return PInputField(
                    controller: codeCont,
                    invalid: controller.codeInvalid,
                    hintText: controller.codeHintText ?? 'ABC1234',
                    hintColor: controller.codeHintText == null
                        ? PTheme.grey : PTheme.colorB,
                  );
                }
              ),
            ],
          ),
        ),
        type: DialogType.bi,
        leftPressed: Get.back,
        rightPressed: joinParty,
      ),
    );
  }

  void joinParty() async {
    final userPresenter = Get.find<UserPresenter>();
    PUser user = userPresenter.loggedUser;

    if (!await validate()) return;
    Party? party = await PartyPresenter.loadParty(codeCont.text);

    if (party == null) return;
    party.records[user.uid!] = user.getAmounts(
      party.challenge!.type!, party.startDate, party.endDate,
    );

    PartyPresenter.save(party);
    userPresenter.joinParty(codeCont.text);

    Get.back();
    ChallengeMain.toChallengeMain();
    ChallengePartyMain.toChallengePartyMain(party);
  }

  Future<bool> validate() async {
    final userPresenter = Get.find<UserPresenter>();
    String text = codeCont.text;

    Map<String, bool> conditions = {
      '이미 참여중인 챌린지 입니다': ! !userPresenter.alreadyJoinedParty(text),
      '해당 코드의 챌린지가 없습니다': !await PartyPresenter.partyExists(text),
      '7글자로 입력해주세요': text.length != 7,
      '공백을 포함할 수 없습니다': text.contains(' '),
      '한글을 포함할 수 없습니다': hasKorean(text),
      '특수문자는 포함할 수 없습니다': RegExp(r'[`~!@#$%^&*|"' r"'‘’””;:/?]").hasMatch(text),
      '별명을 입력해주세요': text == '',
    };

    conditions.forEach((message, condition) {
      if (condition) codeHintText = message;
    });

    if (conditions.values.any((condition) => condition)) {
      codeCont.clear();
      codeInvalid = true; update();
      await Future.delayed(const Duration(milliseconds: 500), () {
        codeInvalid = false; update();
      });
      await Future.delayed(const Duration(milliseconds: 500), () {
        codeCont.text = text; update();
        codeHintText = null;
      });
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    tabCont = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onClose() {
    tabCont.dispose();
    super.onClose();
  }
}
