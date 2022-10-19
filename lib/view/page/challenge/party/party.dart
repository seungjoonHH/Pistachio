import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/database/party.dart';
import 'package:pistachio/view/page/challenge/party/widget.dart';
import 'package:pistachio/view/widget/widget/bottom_bar.dart';

class ChallengePartyMainPage extends StatelessWidget {
  const ChallengePartyMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Party party = Get.arguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: PTheme.background,
      // appBar: const PAppBar(color: Colors.transparent),
      bottomSheet: PBottomSheetBar(body: PartyMainView(party: party)),
    );
  }
}
