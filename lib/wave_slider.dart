import 'package:flutter/material.dart';
import 'package:slider/wave_painter.dart';

class WaveSlider extends StatefulWidget {
  final double width;
  final double height;
  final Color color;

  const WaveSlider({
    this.width = 350.0,
    this.height = 50.0,
    this.color = Colors.black,
    });

  @override
  _WaveSliderState createState() => _WaveSliderState();
}

class _WaveSliderState extends State<WaveSlider> {

  double _dragPosition = 0;
  double _dragPercentage = 0;

  void _updateDragPosition(Offset val) {
    double _newDragPosition = 0;

    if (val.dx <= 0) {
      _newDragPosition = 0;
    } else if (val.dx >= widget.width) {
      _newDragPosition = widget.width;
    } else {
      _newDragPosition = val.dx;
    }
    setState(() {
      _dragPosition = _newDragPosition;
      _dragPercentage = _dragPosition / widget.width;
    });
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset offset = box.globalToLocal(update.globalPosition);
    _updateDragPosition(offset);
  }

  void _onDragStart(BuildContext context, DragStartDetails start) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset offset = box.globalToLocal(start.globalPosition);
    _updateDragPosition(offset);
  }

  void _onDragEnd(BuildContext context, DragEndDetails end) {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Container(
          width: widget.width,
          height: widget.height,
          child: CustomPaint(
            painter: WavePainter(
              color: widget.color,
              dragPercentage: _dragPercentage,
              sliderPosition: _dragPosition,
            ),
          ),
        ),
        onHorizontalDragUpdate: (DragUpdateDetails update) => _onDragUpdate(context, update),
        onHorizontalDragStart: (DragStartDetails start) => _onDragStart(context, start),
        onHorizontalDragEnd: (DragEndDetails end) => _onDragEnd(context, end),
      ),
    );
  }
}


