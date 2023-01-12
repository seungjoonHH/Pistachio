import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/workout/edge.dart';
import 'package:pistachio/model/class/workout/handler.dart';
import 'package:pistachio/model/class/workout/limb.dart';
import 'package:pistachio/model/class/workout/parts.dart';
import 'package:pistachio/model/enum/workout.dart';
import 'package:pistachio/presenter/widget/painter.dart';

class LimbsPainter extends CustomPainter {
  final painterP = Get.find<PainterPresenter>();

  // COLOR PROFILES

  // CORRECT POSTURE COLOR PROFILE
  Paint pointGreen = Paint()
    ..color = Theme.of(Get.context!).colorScheme.primary.withOpacity(.5)
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 8;

  Paint edgeGreen = Paint()
    ..color = Theme.of(Get.context!).colorScheme.primaryContainer.withOpacity(.8)
    ..strokeWidth = 5;

  // INCORRECT POSTURE COLOR PROFILE
  Paint pointRed = Paint()
    ..color = Theme.of(Get.context!).colorScheme.secondary.withOpacity(.5)
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 8;

  Paint edgeRed = Paint()
    ..color = Theme.of(Get.context!).colorScheme.secondaryContainer.withOpacity(.8)
    ..strokeWidth = 5;

  Paint pointBlack = Paint()
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 8;

  Paint edgeBlack = Paint()
    ..color = Colors.black54
    ..strokeWidth = 5;

  // Paint area = Paint()
  //   ..color = Colors.white24;

  Paint area = Paint()
    ..style = PaintingStyle.stroke
    ..color = PTheme.colorB
    ..strokeWidth = 5;

  List<Offset> pointsGreen = [];
  List<Offset> pointsRed   = [];
  List<Offset> pointsBlack = [];

  LimbsPainter({
    required List<dynamic> inferences,
    required List<Limb> limbs
  }) {
    painterP.inferences = inferences;
    painterP.limbs = limbs;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (Limb limb in painterP.limbs) { renderEdge(canvas, limb); }
    canvas.drawPoints(PointMode.points, pointsGreen, pointGreen);
    canvas.drawPoints(PointMode.points, pointsRed, pointRed);
    // canvas.drawPoints(PointMode.points, pointsBlack, pointBlack);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void renderEdge(Canvas canvas, Limb limb) {
    // canvas.drawOval(
    //   Rect.fromCenter(
    //     center: Offset(
    //       PainterPresenter.canvasSize.width * .5,
    //       PainterPresenter.canvasSize.height * .55,
    //     ),
    //     width: PainterPresenter.canvasSize.width * .5,
    //     height: PainterPresenter.canvasSize.height * .75,
    //   ), area,
    // );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(
            PainterPresenter.canvasSize.width * .5,
            PainterPresenter.canvasSize.height * .55,
          ),
          width: PainterPresenter.canvasSize.width * .5,
          height: PainterPresenter.canvasSize.height * .75,
        ), const Radius.circular(40.0),
      ), area,
    );

    bool isHuman = Parts(painterP.inferences).isHuman;

    PainterPresenter.addHumanHistory(isHuman);
    if (!isHuman
        || PainterPresenter.humanHistory < 0
        || painterP.distance != WorkoutDistance.middle) return;

    painterP.staging();

    for (List<dynamic> point in painterP.inferences) {
      if ((point[2] > 0.40) & limb.contains(painterP.inferences.indexOf(point))) {
        Offset offset = Offset(
          point[0].toDouble() + ExerciseHandler.errorX,
          point[1].toDouble() + ExerciseHandler.errorY,
        );
        (limb.isCorrect ? pointsGreen : pointsRed).add(offset);
      }
    }

    for (Edge edge in PainterPresenter.edges) {
      double vertex1X = painterP.inferences[edge.part1.index][0].toDouble() + ExerciseHandler.errorX;
      double vertex1Y = painterP.inferences[edge.part1.index][1].toDouble() + ExerciseHandler.errorY;
      double vertex2X = painterP.inferences[edge.part2.index][0].toDouble() + ExerciseHandler.errorX;
      double vertex2Y = painterP.inferences[edge.part2.index][1].toDouble() + ExerciseHandler.errorY;


      if (limb.contains(edge.part1.index) & limb.contains(edge.part2.index)) {
        canvas.drawLine(
          Offset(vertex1X, vertex1Y),
          Offset(vertex2X, vertex2Y),
          limb.isCorrect ? edgeGreen : edgeRed,
        );
      }
      else {
        // canvas.drawLine(
        //   Offset(vertex1X, vertex1Y),
        //   Offset(vertex2X, vertex2Y),
        //   edgeBlack,
        // );
      }
    }
  }
}
