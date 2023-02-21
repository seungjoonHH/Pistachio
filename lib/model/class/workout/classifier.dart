import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:image/image.dart' as image_lib;

class Classifier {
  late Interpreter interpreter;
  late ImageProcessor imageProcessor;
  late TensorImage inputImage;
  late List<Object> inputs;

  Map<int, Object> outputs = {};
  TensorBuffer outputLocations = TensorBufferFloat([]);

  Stopwatch stopwatch = Stopwatch();
  int frameNo = 0;

  Classifier([Interpreter? interpret]) {
    loadModel(interpret);
  }

  void runModel() async {
    Map<int, Object> outputs = {0: outputLocations.buffer};
    interpreter.runForMultipleInputs(inputs, outputs);
  }

  void loadModel([Interpreter? interpret]) async {
    try {
      interpreter = interpret ?? await Interpreter.fromAsset(
        'model/lite-model_movenet_singlepose_lightning_3.tflite',
        options: InterpreterOptions()..threads = 4,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error while creating interpreter: $e");
      }
    }

    outputLocations = TensorBufferFloat([1, 1, 17, 3]);
  }

  TensorImage getProcessedImage() {
    int padSize = max(inputImage.height, inputImage.width);
    imageProcessor = ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(padSize, padSize))
        .add(ResizeOp(192, 192, ResizeMethod.BILINEAR))
        .build();

    inputImage = imageProcessor.process(inputImage);
    return inputImage;
  }

  void performOperations(CameraImage cameraImage) async {
    stopwatch.start();

    image_lib.Image convertedImage = image_lib.Image(cameraImage.width, cameraImage.height);

    convertedImage.data = cameraImage.planes.first.bytes.buffer.asUint32List();

    inputImage = TensorImage(TfLiteType.float32);
    inputImage.loadImage(convertedImage);
    inputImage = getProcessedImage();

    inputs = [inputImage.buffer];

    stopwatch.stop();
    frameNo += 1;

    stopwatch.reset();
  }

  List parseLandmarkData() {
    List<double> data = outputLocations.getDoubleList();
    List result = [];
    late int x, y;
    late double c;

    for (var i = 0; i < 51; i += 3) {
      y = (data[0 + i] * 640).toInt();
      x = (data[1 + i] * 480).toInt();
      c = (data[2 + i]);
      result.add([x, y, c]);
    }
    // outputParsed = result;

    return result;
  }
}
