import 'dart:io';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:pistachio/model/class/workout/classifier.dart';
import 'package:pistachio/model/class/workout/isolate.dart';

class CameraPresenter extends GetxController {
  static List<CameraDescription>? descriptions;
  CameraController? cameraController;
  static late Classifier classifier;
  static late IsolateUtils isolate;

  late List<dynamic> inferences;

  int direction = 0;

  Future init() async {
    isolate = IsolateUtils();
    await isolate.start();

    classifier = Classifier();
    classifier.loadModel();

    await loadCamera(direction);
    update();
  }

  Future toggleDirection() async {
    direction = 1 - direction;
    await loadCamera(direction);
    update();
  }

  Future loadCamera([direction = 0]) async {
    if (descriptions == null) return;

    if (Platform.isIOS) {
      cameraController = CameraController(
        descriptions![direction], ResolutionPreset.medium,
      );
    }
    await cameraController!.initialize();
  }

  static Future<List<dynamic>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolate.sendPort.send(isolateData..responsePort = responsePort.sendPort);
    var results = await responsePort.first;
    return results;
  }
}