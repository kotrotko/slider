import 'package:flutter/material.dart';
import 'package:slider/wave_slider.dart';

void main() =>
  runApp(MaterialApp(
      home: WaveApp()
  ));


class WaveApp extends StatefulWidget {

  @override
  _WaveAppState createState() => _WaveAppState();
}

class _WaveAppState extends State<WaveApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Wave Slider"),
        ),
        body: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: WaveSlider(),
            ),
          ),
      );
  }
}
