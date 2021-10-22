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
          leading: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image(image: AssetImage("assets/long-arrow-pointing-to-left.png"))),
          backgroundColor: Colors.white,
        ),
        body: Container(
          padding: EdgeInsets.all(32.0),
          color: Colors.white,
          child: Center(
            child: WaveSlider(),
            ),
          ),
    );
  }
}
