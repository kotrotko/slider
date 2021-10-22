import 'package:flutter/material.dart';

import 'package:slider/wave_slider.dart';

void main() =>
  runApp(MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0, // This removes the shadow from all App Bars.
          )
      ),
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
          backgroundColor: Colors.white12,
          leading: Padding(
              padding: EdgeInsets.all(12.0),
              child: Image(image: AssetImage("assets/long-arrow-pointing-to-left.png"))),
        ),
        body: Container(
          //padding: EdgeInsets.all(32.0),
          color: Colors.white12,
          child: Center(
            child: WaveSlider(),
            ),
          ),
    );
  }
}
