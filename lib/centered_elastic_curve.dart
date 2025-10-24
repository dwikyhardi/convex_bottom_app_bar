import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A custom curve that creates an elastic out animation centered around 0.5.
///
/// The curve is similar to Flutter's built-in ElasticOutCurve, but is modified
/// to be centered. The [period] parameter controls the oscillation period.
class CenteredElasticOutCurve extends Curve {
  /// Creates a centered elastic out curve.
  ///
  /// The [period] parameter controls the oscillation period. Defaults to 0.4.
  const CenteredElasticOutCurve([this.period = 0.4]);

  /// The period of the elastic oscillation. Controls the frequency of the curve's oscillation.
  final double period;

  @override
  double transform(double t) {
    // Bascially just a slightly modified version of the built in ElasticOutCurve
    return math.pow(2.0, -10.0 * t) * math.sin(t * 2.0 * math.pi / period) +
        0.5;
  }
}

/// A custom curve that creates an elastic in animation centered around 0.5.
///
/// The curve is similar to Flutter's built-in ElasticInCurve, but is modified
/// to be centered. The [period] parameter controls the oscillation period.
class CenteredElasticInCurve extends Curve {
  /// Creates a centered elastic in curve.
  ///
  /// The [period] parameter controls the oscillation period. Defaults to 0.4.
  const CenteredElasticInCurve([this.period = 0.4]);

  /// The period of the elastic oscillation. Controls the frequency of the curve's oscillation.
  final double period;

  @override
  double transform(double t) {
    // Bascially just a slightly modified version of the built in ElasticInCurve
    return -math.pow(2.0, 10.0 * (t - 1.0)) *
            math.sin((t - 1.0) * 2.0 * math.pi / period) +
        0.5;
  }
}

/// A custom curve that linearly interpolates between two points.
///
/// The curve transitions from [pIn] to [pOut] using linear interpolation.
class LinearPointCurve extends Curve {
  /// Creates a linear point curve.
  ///
  /// [pIn] is the input threshold, [pOut] is the output threshold.
  const LinearPointCurve(this.pIn, this.pOut);

  /// The input threshold for the curve.
  final double pIn;

  /// The output threshold for the curve.
  final double pOut;

  @override
  double transform(double t) {
    // Just a simple bit of linear interpolation math
    final lowerScale = pOut / pIn;
    final upperScale = (1.0 - pOut) / (1.0 - pIn);
    final upperOffset = 1.0 - upperScale;
    return t < pIn ? t * lowerScale : t * upperScale + upperOffset;
  }
}
