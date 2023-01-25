import 'dart:io';
import 'dart:isolate';
import 'dart:math';

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

  int direction = 1;
  late double scaleInitZoom = 0;
  double zoom = 1.0;

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
    await cameraController!.setZoomLevel(zoom);
  }

  void setInitZoom() => scaleInitZoom = zoom;

  Future setZoomLevel(double scale) async {
    zoom = max(1.0, min(scale * scaleInitZoom, 189.0));
    await cameraController!.setZoomLevel(zoom);
  }

  static Future<List<dynamic>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolate.sendPort.send(isolateData..responsePort = responsePort.sendPort);
    var results = await responsePort.first;
    return results;
  }
}