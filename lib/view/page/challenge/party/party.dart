import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/party.dart';
import 'package:pistachio/view/page/challenge/party/widget.dart';

class ChallengePartyMainPage extends StatelessWidget {
  const ChallengePartyMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Party party = Get.arguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: PTheme.background,
      // appBar: const PAppBar(color: Colors.transparent),
      body: PartyMainView(party: party),
    );
  }
}
