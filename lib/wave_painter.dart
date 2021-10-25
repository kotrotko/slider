import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:slider/wave_slider.dart';

class WavePainter extends CustomPainter {

  final double? sliderPosition;
  final double? dragPercentage;

  final double? animationProgress;

  final SliderState? sliderState;

  final Color? color;

  double _previousSliderPosition = 0;

  final Paint fillPainter;
  final Paint wavePainter;

  WavePainter({
    @required this.sliderPosition,
    @required this.dragPercentage,
    @required this.color,
    @required this.animationProgress,
    @required this.sliderState,

  }): fillPainter = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill,
      wavePainter = Paint()
        ..color = color!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;

  @override
  void paint(Canvas canvas, Size size) {
    //_paintAnchors(canvas, size);

    // _paintSlidingWave(canvas, size);
    print('state $sliderState');
    switch(sliderState){
      case (SliderState.starting):
        _paintStartupWave(canvas, size);
        break;
      case (SliderState.resting):
        _paintRestingWave(canvas, size);
        break;
      case (SliderState.sliding):
        _paintSlidingWave(canvas, size);
        break;
      case (SliderState.stopping):
        _paintStoppingWave(canvas, size);
        break;
      default:
        _paintRestingWave(canvas, size);
        break;
    }

    _paintBlock(canvas, size);
    // _paintLine(canvas, size);
  }

  _paintStartupWave(Canvas canvas, Size size) {
    WaveCurveDefinitions line = _calculateWaveLineDefinitions(size);

    //double waveHeight =lerpDouble(size.height, line.controlHeight, Curves.elasticOut.transform(animationProgress));
    //line.controlHeight = waveHeight;
    _paintWaveLine(canvas, size, line);
  }

  _paintRestingWave(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, wavePainter);
  }

  _paintSlidingWave(Canvas canvas, Size size) {
    WaveCurveDefinitions curveDefinitions = _calculateWaveLineDefinitions(size);
    _paintWaveLine(canvas, size, curveDefinitions);
  }
  _paintStoppingWave(Canvas canvas, Size size) {
    WaveCurveDefinitions line = _calculateWaveLineDefinitions(size);

    //double waveHeight =lerpDouble(line.controlHeight, size.height, Curves.elasticOut.transform(animationProgress));
    //line.controlHeight = waveHeight;
    _paintWaveLine(canvas, size, line);
  }

  _paintAnchors(Canvas canvas, Size size){
    canvas.drawCircle(Offset(100.0, size.height), 5.0, fillPainter);
  //   canvas.drawCircle(Offset(size.width, size.height), 0.0, fillPainter);
  }

  WaveCurveDefinitions _calculateWaveLineDefinitions(Size size){
    double minWaveHeight = size.height * 0.3;
    // double maxWaveHeight = size.height * 0.8;
    //
    // double controlHeight = (size.height - minWaveHeight) - (maxWaveHeight * dragPercentage);
    double controlHeight = size.height - minWaveHeight;

    double bendWidth = 30.0;
    double bezierWidth = 30.0;
    //double bendWidth = 20.0 + 20.0 * dragPercentage;
    //double bezierWidth = 20.0 + 20.0 * dragPercentage;

    double centerPoint = sliderPosition!;
    centerPoint = (centerPoint > size.width) ? size.width : centerPoint;

    double startOfBend = sliderPosition! - bendWidth / 2;
    double startOfBezier = startOfBend - bezierWidth;
    double endOfBend = sliderPosition! + bendWidth / 2;
    double endOfBezier = endOfBend + bezierWidth;

    startOfBend = (startOfBend <= 0.0) ? 0.0 : startOfBend;
    startOfBezier = (startOfBezier <= 0.0) ? 0.0 : startOfBezier;
    endOfBend = (endOfBend >= size.width) ? size.width : endOfBend;
    endOfBezier = (endOfBezier >= size.width) ? size.width : endOfBezier;

    //double controlHeight = 0.0;

    double leftControlPoint1 = startOfBend;
    double leftControlPoint2 = startOfBend;
    double rightControlPoint1 = endOfBend;
    double rightControlPoint2 = endOfBend;

    double bendability = 25.0;
    double maxSlideDifference = 30.0;

    double slideDifference = (sliderPosition! - _previousSliderPosition).abs();
    // if (slideDifference > maxSlideDifference){
    //   slideDifference = maxSlideDifference;
    // }
    slideDifference = (slideDifference > maxSlideDifference) ? maxSlideDifference : slideDifference;

    bool moveLeft = sliderPosition! < _previousSliderPosition;

    double? bend = lerpDouble(0.0, bendability, slideDifference / maxSlideDifference);

    bend = moveLeft ? -bend! : bend;

    leftControlPoint1 = leftControlPoint1 + bend!;
    leftControlPoint2 = leftControlPoint2 - bend;
    rightControlPoint1 = rightControlPoint1 - bend;
    rightControlPoint2 = rightControlPoint2 + bend;
    centerPoint = centerPoint - bend;

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

  _paintWaveLine(Canvas canvas, Size size, WaveCurveDefinitions waveCurve) {
    // WaveCurveDefinitions waveCurve = _calculateWaveLineDefinitions(size);

    Path path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(waveCurve.startOfBezier, size.height);
    path.cubicTo(
        waveCurve.leftControlPoint1, size.height, waveCurve.leftControlPoint2, waveCurve.controlHeight,
        waveCurve.centerPoint, waveCurve.controlHeight);
    path.cubicTo(
        waveCurve.rightControlPoint1, waveCurve.controlHeight, waveCurve.rightControlPoint2, size.height,
        waveCurve.endOfBezier, size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, wavePainter);
  }

  _paintBlock(Canvas canvas, Size size){

    final borderPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: sliderPosition!*0.015 + 15,
      fontWeight: FontWeight.bold,
    );

    final textSpan = TextSpan(
      text: (40 + (sliderPosition! * 0.2)).toInt().toString() + " kg",
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      //textAlign: TextAlign.center,
      textAlign: TextAlign.start,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: 75,
    );

    //creating the tooltip position
    Offset toolTipOffset = Offset(((sliderPosition! - 10.0) - sliderPosition!*0.03), size.height - 80.0);

    //creating the text position
    Offset textOffset = Offset(toolTipOffset.dx, toolTipOffset.dy);

     canvas.drawRRect(RRect.fromRectAndCorners(Offset((sliderPosition! - 40.0), size.height - 100.0) & Size((sliderPosition!*0.1 + 80.0), (sliderPosition!*0.05 + 50.0)),
       topRight: Radius.circular(8), topLeft: Radius.circular(8), bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8)), Paint());

    canvas.drawCircle(Offset(sliderPosition!, size.height + 15.0), 8.0, fillPainter);

    //painting the text
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    _previousSliderPosition = oldDelegate.sliderPosition!;
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
  //double controlHeight;
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