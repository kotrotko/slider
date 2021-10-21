import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WavePainter extends CustomPainter {

  final double? sliderPosition;
  final double? dragPercentage;

  final Color? color;

  final Paint fillPainter;
  final Paint wavePainter;

  WavePainter({
    @required this.sliderPosition,
    @required this.dragPercentage,
    @required this.color,
  }): fillPainter = Paint()
    ..color = color!
    ..style = PaintingStyle.fill,
      wavePainter = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;

  @override
  void paint(Canvas canvas, Size size) {
    // _paintAnchors(canvas, size);
    // _paintLine(canvas, size);
    _paintBlock(canvas, size);
    _paintWaveLine(canvas, size);
  }

  _paintAnchors(Canvas canvas, Size size){
    canvas.drawCircle(Offset(0.0, size.height), 5.0, fillPainter);
    canvas.drawCircle(Offset(size.width, size.height), 5.0, fillPainter);
  }

  WaveCurveDefinitions _calculateWaveLineDefinitions(){
    double bendWidth = 40.0;
    double bezierWidth = 40.0;
    double startOfBend = sliderPosition! - bendWidth / 2;
    double startOfBezier = startOfBend - bezierWidth;
    double endOfBend = sliderPosition! + bendWidth / 2;
    double endOfBezier = endOfBend + bezierWidth;
    double controlHeight = 0.0;
    double centerPoint = sliderPosition!;
    double leftControlPoint1 = startOfBend;
    double leftControlPoint2 = startOfBend;

    double rightControlPoint1 = endOfBend;
    double rightControlPoint2 = endOfBend;

    WaveCurveDefinitions waveCurve = WaveCurveDefinitions(
      centerPoint: centerPoint,
      controlHeight: controlHeight,
      startOfBezier: startOfBezier,
      startOfBend: startOfBend,
      endOfBezier: endOfBezier,
      endOfBend: endOfBend,
      leftControlPoint1: leftControlPoint1,
      leftControlPoint2: leftControlPoint2,
      rightControlPoint1: rightControlPoint1,
      rightControlPoint2: rightControlPoint2,
    );
    return waveCurve;
  }

  _paintWaveLine(Canvas canvas, Size size) {
    WaveCurveDefinitions waveCurve = _calculateWaveLineDefinitions();

    Path path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(waveCurve.startOfBezier, size.height);
    path.cubicTo(waveCurve.leftControlPoint1, size.height, waveCurve.leftControlPoint2, waveCurve.controlHeight, waveCurve.centerPoint, waveCurve.controlHeight);
    path.cubicTo(waveCurve.rightControlPoint1, waveCurve.controlHeight, waveCurve.rightControlPoint2, size.height, waveCurve.endOfBezier, size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, wavePainter);
  }

  _paintLine(Canvas canvas, Size size){
    Path path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, wavePainter);
  }

  _paintBlock(Canvas canvas, Size size){
    Rect sliderRect = Offset(sliderPosition!, size.height - 5.0) & Size(3.0, 10.0);
    canvas.drawRect(sliderRect, fillPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class WaveCurveDefinitions {
  final double startOfBezier;
  final double endOfBezier;
  final double startOfBend;
  final double endOfBend;
  final double leftControlPoint1;
  final double leftControlPoint2;
  final double rightControlPoint1;
  final double rightControlPoint2;
  final double controlHeight;
  final double centerPoint;

  WaveCurveDefinitions({
    required this.startOfBezier,
    required this.endOfBezier,
    required this.startOfBend,
    required this.endOfBend,
    required this.leftControlPoint1,
    required this.leftControlPoint2,
    required this.rightControlPoint1,
    required this.rightControlPoint2,
    required this.controlHeight,
    required this.centerPoint,
  });
}