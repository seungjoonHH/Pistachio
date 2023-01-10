import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/number.dart';
import 'package:pistachio/model/class/workout/handler.dart';
import 'package:pistachio/model/class/workout/isolate.dart';
import 'package:pistachio/model/enum/workout.dart';
import 'package:pistachio/presenter/widget/camera.dart';
import 'package:pistachio/presenter/widget/painter.dart';
import 'package:pistachio/view/widget/painter/painter.dart';

class WorkoutMainPage extends StatefulWidget {
  const WorkoutMainPage({Key? key}) : super(key: key);

  @override
  State<WorkoutMainPage> createState() => _WorkoutMainPageState();
}

class _WorkoutMainPageState extends State<WorkoutMainPage> {
  final cameraP = Get.find<CameraPresenter>();

  bool predicting = false;
  bool initialize = false;

  List<dynamic>? inferences;
  late ExerciseHandler handler;

  late WorkoutView view;

  static int historyMax = 4;
  int frameCount = 0;

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

  void initAsync() async {
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
      historyX[i][frameCount % historyMax] = inferenceResults[i][0];
      historyY[i][frameCount % historyMax] = inferenceResults[i][1];
      historyC[i][frameCount % historyMax] = inferenceResults[i][2];
    }

    for (int i = 0; i < inferenceResults.length; i++) {
      const int thresholdX = 50;
      const int thresholdY = 50;

      int refinedX = average(historyX[i]).toInt();
      int refinedY = average(historyY[i]).toInt();
      double refinedC = average([...historyC[i]]).toDouble();

      if (frameCount < historyMax) {
        refinedInferences[i][0] = refinedX;
        refinedInferences[i][1] = refinedY;
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

    setState(() {
      // inferenceResults
      // refinedInferences
      inferences = refinedInferences;
      predicting = false;
      initialize = true;
      handler.checkLimbs(refinedInferences);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (inferences == null) return const Scaffold();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
        actions: [
          GetBuilder<CameraPresenter>(
              builder: (cameraP) {
                return IconButton(
                  onPressed: () async => await cameraP.toggleDirection(),
                  icon: const Icon(Icons.camera_alt),
                );
              }
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              width: PainterPresenter.canvasSize.width,
              height: PainterPresenter.canvasSize.height,
              child: CustomPaint(
                foregroundPainter: LimbsPainter(
                  inferences: inferences!,
                  limbs: handler.limbs,
                ),
                child: GetBuilder<CameraPresenter>(
                  builder: (cameraP) {
                    return CameraPreview(cameraP.cameraController!);
                  }
                ),
              ),
            ),
          ),
          GetBuilder<PainterPresenter>(
            builder: (painterP) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      if (PainterPresenter.humanHistory > 0)
                      Text(painterP.distance.desc,
                        style: Theme.of(context).textTheme.titleLarge,
                      ) else if (painterP.currentStage == WorkoutStage.fast)
                      Text('동작이 너무 빠릅니다.', style: Theme.of(context).textTheme.titleLarge)
                      else Text('사람이 감지되지 않습니다.', style: Theme.of(context).textTheme.titleLarge)
                    ],
                  ),
                  if (painterP.distance == WorkoutDistance.middle)
                  Text(
                    painterP.view.kr,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '${painterP.count} 개',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
