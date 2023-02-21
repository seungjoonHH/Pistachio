import 'dart:math';

import 'package:pistachio/global/number.dart';
import 'package:pistachio/model/enum/part.dart';

class Parts {
  Map<Part, Point> points = {};
  Map<Part, double> probs = {};

  Parts(List<dynamic> inferences) {
    for (int i = 0; i < inferences.length; i++) {
      points[Part.values[i]] = Point(inferences[i][0], inferences[i][1]);
      probs[Part.values[i]] = inferences[i][2].toDouble();
    }
  }

  static bool similar(num n1, num n2) {
    return (n1 - n2).abs() < 40;
  }

  bool get isHuman {
    return average(probs.values.toList().sublist(11)) > .3;
  }
}