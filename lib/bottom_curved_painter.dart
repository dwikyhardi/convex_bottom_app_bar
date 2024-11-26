import 'package:convex_bottom_app_bar/centered_elastic_curve.dart';
import 'package:flutter/material.dart';

class BackgroundCurvePainter extends CustomPainter {
  BackgroundCurvePainter({
    required double x,
    required double normalizedY,
    required Color backgroundColor,
    required Color indicatorColor,
    required double indicatorWidth,
    required bool isJustIndicator,
  })  : _x = x,
        _normalizedY = normalizedY,
        _indicatorColor = indicatorColor,
        _backgroundColor = backgroundColor,
        _indicatorWidth = indicatorWidth,
        _isJustIndicator = isJustIndicator;
  static const _topDistance = 0.0;
  static const _bottomDistance = 100.0;

  final double _x;
  final double _normalizedY;
  final Color _indicatorColor;
  final Color _backgroundColor;
  final double _indicatorWidth;
  final bool _isJustIndicator;

  @override
  void paint(canvas, size) {
    // Paint two cubic bezier curves using various linear interpolations based off of the `_normalizedY` value
    final norm = const LinearPointCurve(0.5, 2.0).transform(_normalizedY) / 5;

    final dist = Tween<double>(begin: _topDistance, end: _bottomDistance)
        .transform(const LinearPointCurve(0.5, 0.0).transform(norm));
    final x1 = _x - (dist / 2);

    final indicatorPath = Path()
      ..moveTo(_x, 0)
      ..addRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
              center: Offset(x1, 0),
              width: _indicatorWidth - 16,
              height: 4,
            ),
            const Radius.circular(4)),
      );

    final indicatorPaint = Paint()..color = _indicatorColor;
    final backgroundPaint = Paint()..color = _backgroundColor;

    final backgroundPath = Path()
      ..moveTo(0, 0)
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    if (!_isJustIndicator) {
      canvas.drawPath(backgroundPath, backgroundPaint);
    }
    canvas.drawPath(indicatorPath, indicatorPaint);
  }

  @override
  bool shouldRepaint(BackgroundCurvePainter oldDelegate) {
    return _x != oldDelegate._x ||
        _normalizedY != oldDelegate._normalizedY ||
        _backgroundColor != oldDelegate._backgroundColor ||
        _indicatorColor != oldDelegate._indicatorColor;
  }
}
