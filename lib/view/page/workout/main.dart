import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/number.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/workout/handler.dart';
import 'package:pistachio/model/class/workout/isolate.dart';
import 'package:pistachio/model/enum/workout.dart';
import 'package:pistachio/presenter/page/workout/main.dart';
import 'package:pistachio/presenter/widget/camera.dart';
import 'package:pistachio/presenter/widget/painter.dart';
import 'package:pistachio/view/widget/button/button.dart';
import 'package:pistachio/view/widget/painter/painter.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class WorkoutMainPage extends StatefulWidget {
  const WorkoutMainPage({Key? key}) : super(key: key);

  @override
  State<WorkoutMainPage> createState() => _WorkoutMainPageState();
}

class _WorkoutMainPageState extends State<WorkoutMainPage> {
  bool predicting = false;
  bool initialize = false;

  List<dynamic>? inferences;
  late ExerciseHandler handler;

  late WorkoutView view;

  static int historyMax = 4;
  int frameCount = 0;

  late LimbsPainter painter;

  List<List<int>> historyX = List.generate(
    17, (_) => List.generate(historyMax, (_) => 0),
  );
  List<List<int>> historyY = List.generate(
    17, (_) => List.generate(historyMax, (_) => 0),
  );
  List<List<double>> historyC = List.generate(
    17, (_) => List.generate(historyMax, (_) => .0),
  );

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  @override
  void dispose() {
    super.dispose();

    final cameraP = Get.find<CameraPresenter>();
    final workoutMain = Get.find<WorkoutMain>();
    workoutMain.init();
    cameraP.cameraController!.dispose();
  }

  void initAsync() async {
    final cameraP = Get.find<CameraPresenter>();
    await cameraP.init();
    await cameraP.cameraController!
        .startImageStream(createIsolate);
    handler = SquatHandler();
    handler.init();
    setState(() {});
  }

  void createIsolate(CameraImage imageStream) async {
    if (predicting) return;
    predicting = true;

    IsolateData isolateData = IsolateData(
      cameraImage: imageStream,
      interpreterAddress: CameraPresenter.classifier.interpreter.address,
    );

    List inferenceResults = await CameraPresenter.inference(isolateData);
    List refinedInferences = List.generate(inferenceResults.length, (_) => [0, 0, .0]);

    for (int i = 0; i < inferenceResults.length; i++) {
      historyX[i][frameCount % historyMax] = inferenceResults[i][0] - 68;
      historyY[i][frameCount % historyMax] = inferenceResults[i][1] - 68;
      historyC[i][frameCount % historyMax] = inferenceResults[i][2];
    }

    for (int i = 0; i < inferenceResults.length; i++) {
      const int thresholdX = 50;
      const int thresholdY = 50;

      int refinedX = average(historyX[i]).round();
      int refinedY = average(historyY[i]).round();
      double refinedC = average(historyC[i]).toDouble();

      if (frameCount < historyMax) {
        refinedInferences[i][0] = refinedX - 68;
        refinedInferences[i][1] = refinedY - 68;
        refinedInferences[i][2] = refinedC;
        continue;
      }

      refinedInferences[i][0] = (refinedX - historyX[i][frameCount % historyMax]).abs() > thresholdX
          ? historyX[i][(frameCount % historyMax - 1) ~/ historyMax] : refinedX;
      refinedInferences[i][1] = (refinedY - historyY[i][frameCount % historyMax]).abs() > thresholdY
          ? historyY[i][(frameCount % historyMax - 1) ~/ historyMax] : refinedY;
      refinedInferences[i][2] = refinedC;

      // refinedInferences[i][0] = ([...historyX[i]]..sort((a, b) => a - b))[historyMax ~/ 2];
      // refinedInferences[i][1] = ([...historyY[i]]..sort((a, b) => a - b))[historyMax ~/ 2];
      // refinedInferences[i][2] = ([...historyC[i]]..sort((a, b) => (a - b).toInt()))[historyMax ~/ 2];
    }

    frameCount++;

    if (!mounted) return;

    setState(() {
      // inferenceResults
      // refinedInferences
      inferences = refinedInferences;
      predicting = false;
      initialize = true;
      handler.checkLimbs(refinedInferences);

      painter = LimbsPainter(
        inferences: inferences!,
        limbs: handler.limbs,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    if (inferences == null) return const Scaffold();

    return GetBuilder<CameraPresenter>(
      builder: (cameraP) {
        return OrientationBuilder(
          builder: (context, orientation) {
            PainterPresenter.setScreenRatio(orientation);
            return Scaffold(
              appBar: PAppBar(
                title: '운동하기',
                actions: [
                  IconButton(
                    onPressed: () async {
                      cameraP.toggleDirection();
                      initAsync();
                    },
                    icon: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
              body: GetBuilder<PainterPresenter>(
                builder: (painterP) {
                  return Column(
                    children: [
                      SizedBox(
                        // width: PainterPresenter.canvasSize.width,
                        height: PainterPresenter.canvasSize.height,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              foregroundPainter: painter,
                              child: CameraPreview(
                                cameraP.cameraController!,
                              ),
                            ),
                            GestureDetector(
                              onScaleStart: (details) => cameraP.setInitZoom(),
                              onScaleUpdate: (details) {
                                cameraP.setZoomLevel(details.scale);
                              },
                            ),
                            if (painterP.stateText != null)
                            PText(
                              painterP.stateText!,
                              style: textTheme.displayLarge,
                              color: painterP.stateText == 'READY'
                                  ? PTheme.colorC : PTheme.colorA,
                              border: true,
                            ),
                            if (painterP.floatingMessage != null)
                            Positioned(
                              bottom: 30.0.h,
                              child: Container(
                                alignment: Alignment.center,
                                width: PainterPresenter.canvasSize.width * .8,
                                height: 70.h,
                                constraints: const BoxConstraints(maxWidth: 340.0),
                                decoration: BoxDecoration(
                                  color: PTheme.white.withOpacity(.6),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: PText(
                                  painterP.floatingMessage!,
                                  style: textTheme.headlineSmall,
                                ),
                              ),
                            ),
                            if (painterP.count > 0
                                && painterP.state == WorkoutState.stop)
                            GetBuilder<WorkoutMain>(
                              builder: (workoutMain) {
                                return Positioned(
                                  bottom: 30.0.h,
                                  child: PButton(
                                    height: 80.h,
                                    stretch: true,
                                    constraints: BoxConstraints(maxWidth: 300.0.w),
                                    backgroundColor: PTheme.colorD,
                                    onPressed: workoutMain.finishWorkout,
                                    child: Text('${painterP.count} 개로 운동 완료하기',
                                      style: textTheme.headlineSmall,
                                    ),
                                  ),
                                );
                              }
                            ),
                            // Container(
                            //   width: 370,
                            //   height: 494,
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            PCircledButton(
                              onPressed: painterP.initCount,
                              backgroundColor: PTheme.lightGrey,
                              enabled: painterP.state == WorkoutState.workout,
                              child: PText('취소', style: textTheme.titleLarge),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (painterP.view != WorkoutView.unrecognized)
                                PText(
                                  painterP.view.kr,
                                  style: textTheme.headlineSmall,
                                ),
                                PText(
                                  '${painterP.count} 개',
                                  style: textTheme.headlineMedium,
                                ),
                              ],
                            ),
                            if (painterP.state == WorkoutState.workout)
                            PCircledButton(
                              onPressed: painterP.workout,
                              backgroundColor: PTheme.colorA,
                              child: PText('중지', style: textTheme.titleLarge),
                            ) else PCircledButton(
                              onPressed: painterP.workout,
                              backgroundColor: PTheme.colorB,
                              child: PText('시작', style: textTheme.titleLarge),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              ),
            );
          }
        );
      },
    );
  }
}
