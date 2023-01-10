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
    return (n1 - n2).abs() < 100;
  }

  bool get isHuman {
    return average(probs.values.toList()) > .3;
    // Point sL = points[Part.shoulderL]!;
    // Point hL = points[Part.hipL]!;
    // Point aL = points[Part.ankleL]!;
    //
    // Point sR = points[Part.shoulderR]!;
    // Point hR = points[Part.hipR]!;
    // Point aR = points[Part.ankleR]!;
    //
    // // return (sL.y < hL.y && hL.y < aL.y && sR.y < hR.y && hR.y < aR.y);
    // return (sL.y < hL.y && hL.y < aL.y && sR.y < hR.y && hR.y < aR.y)
    //     && (similar(sL.y, sR.y) && similar(hL.y, hR.y) && similar(aL.y, aR.y))
    //     && (similar(sL.y - hL.y, hL.y - aL.y) && similar(sR.y - hR.y, hR.y - aR.y));
  }
}