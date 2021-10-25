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
  int _personWeigt = 40;

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
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50.0),
                      Text("What is your weight goal?",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      SizedBox(height: 50.0),
                      Text("underweight or overweight",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        )
                      ),
                      SizedBox(height: 50.0),
                      Text(_personWeigt.toString()),
                  ]
                )),
                SizedBox(height: 50.0),
                WaveSlider(),
                SizedBox(height: 50.0),
                ElevatedButton(
                  child: Text('Continue'),
                  onPressed: () {  },
                ),
              ],
            ),
            ),
          ),
    );
  }
}
