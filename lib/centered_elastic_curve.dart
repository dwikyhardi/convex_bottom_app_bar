import 'dart:math' as math;

import 'package:flutter/material.dart';

class CenteredElasticOutCurve extends Curve {
  final double period;

  const CenteredElasticOutCurve([this.period = 0.4]);

  @override
  double transform(double t) {
    // Bascially just a slightly modified version of the built in ElasticOutCurve
    return math.pow(2.0, -10.0 * t) * math.sin(t * 2.0 * math.pi / period) +
        0.5;
  }
}

class CenteredElasticInCurve extends Curve {
  final double period;

  const CenteredElasticInCurve([this.period = 0.4]);

  @override
  double transform(double t) {
    // Bascially just a slightly modified version of the built in ElasticInCurve
    return -math.pow(2.0, 10.0 * (t - 1.0)) *
            math.sin((t - 1.0) * 2.0 * math.pi / period) +
        0.5;
  }
}

class LinearPointCurve extends Curve {
  final double pIn;
  final double pOut;

  const LinearPointCurve(this.pIn, this.pOut);

  @override
  double transform(double t) {
    // Just a simple bit of linear interpolation math
    final lowerScale = pOut / pIn;
    final upperScale = (1.0 - pOut) / (1.0 - pIn);
    final upperOffset = 1.0 - upperScale;
    return t < pIn ? t * lowerScale : t * upperScale + upperOffset;
  }
}
