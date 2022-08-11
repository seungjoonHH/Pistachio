/* 챌린지 메인 위젯 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// 챌린지 메인 리스트 뷰
class ChallengeListView extends StatelessWidget {
  const ChallengeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          ChallengeCard(
            color: 0xff3198D1,
            buttonColor: 0xff11456A,
            imageUrl: 'assets/image/object/beach.svg',
            title: '향고래에게\n무슨 일이?',
            desc: '갑자기 해변에 떠내려온 향고래 한마리!\n도대체 무슨 일이지?',
          ),
          ChallengeCard(
            color: 0xff404040,
            buttonColor: 0xff000000,
            imageUrl: 'assets/image/object/naroho.svg',
            title: '발사가\n코앞인데...',
            desc: '발사가 코앞으로 다가왔는데\n나로호를 발사하지 못하는 속사정은?',
          ),
        ],
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  final int color;
  final int buttonColor;
  final String imageUrl;
  final String title;
  final String desc;

  const ChallengeCard(
      {Key? key,
        required this.color,
        required this.buttonColor,
        required this.imageUrl,
        required this.title,
        required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 500.0,
        child: Card(
          color: Color(color),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                    imageUrl,
                    height: 220.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 36.0),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(buttonColor),
                      fixedSize: const Size.fromWidth(200.0),
                    ),
                    onPressed: null,
                    child: const Text(
                      '알아보러 가기',
                      style:
                      TextStyle(color: Color(0xffFFFFFF), fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
