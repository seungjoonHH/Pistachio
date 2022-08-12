import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/page/challenge.dart';
import 'package:pistachio/presenter/page/exercise/main.dart';
import 'package:pistachio/presenter/page/record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              color: PTheme.secondary[40],
              child: InkWell(
                onTap: ExerciseMain.toExerciseMain,
                borderRadius: BorderRadius.circular(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      SvgPicture.asset('assets/image/object/balls.svg'),
                      const Text('운동하러 가기',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: PTheme.white,
                        ),
                      ),
                      const Positioned(
                        right: 0.0,
                        bottom: 0.0,
                        child: Icon(
                          Icons.timelapse_sharp,
                          size: 100,
                          color: PTheme.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 172.0,
                  height: 172.0,
                  child: Card(
                    color: PTheme.secondary[40],
                    child: InkWell(
                      onTap: RecordPresenter.toRecordMain,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('내 기록\n보러가기',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: PTheme.white,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.dvr,
                                  size: 60.0,
                                  color: PTheme.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 172.0,
                  height: 172.0,
                  child: Card(
                    color: PTheme.secondary[40],
                    child: InkWell(
                      onTap: ChallengePresenter.toChallengeMain,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('챌린지',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: PTheme.white,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.military_tech_outlined,
                                  size: 60.0,
                                  color: PTheme.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
