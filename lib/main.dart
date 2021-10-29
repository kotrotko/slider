import 'package:flutter/material.dart';

import 'package:slider/wave_slider.dart';
import 'package:slider/success_page.dart';


void main() =>
  runApp(MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0, // This removes the shadow from all App Bars.
          )
      ),
      home: WaveApp(),

  ));


class WaveApp extends StatefulWidget {

  @override
  _WaveAppState createState() => _WaveAppState();
}

class _WaveAppState extends State<WaveApp> {
  int _personWeigt = 0;
  TextStyle weightBalanceStyle = TextStyle(
    fontSize: 22,
    color: Colors.grey,
  );

  void state() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      //HomePage(state),
      SuccessPage(),
    ];

    void toSuccessPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessPage()),
      );
    }

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
                      Column(
                        //child: Text(_personWeigt.toString(),
                        children: <Widget>[
                          if (_personWeigt < 23)
                            Text("Underweight", style: weightBalanceStyle)
                          else if (_personWeigt > 66)
                            Text("Overweight", style: weightBalanceStyle)
                          else
                            Text("Balanced", style: weightBalanceStyle),
                      ]),
                      SizedBox(height: 50.0),
                  ]
                )),
                SizedBox(height: 50.0),
                WaveSlider(onChanged: (double val){
                  setState(() {
                    _personWeigt = (val * 100).round();
                  });
                },),
                SizedBox(height: 50.0),
                ElevatedButton(
                  child: Text('Continue'),
                  onPressed: toSuccessPage,
                ),
              ],
            ),
            ),
          ),
    );
  }
}
