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
  int _personWeight = 0;
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
              padding: EdgeInsets.only(left: 30.0),
              //child: ElevatedButton(
              child: Image(image: AssetImage("assets/icons8-left-arrow-48.png")),
               //onPressed: (){},
              //),
          ),
        ),
        body: Container(
          color: Colors.white12,
          child: Center(
            child: Column(
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
                        //child: Text(_personWeight.toString(),
                        children: <Widget>[
                          if (_personWeight < 23)
                            Text("Underweight", style: weightBalanceStyle)
                          else if (_personWeight > 66)
                            Text("Overweight", style: weightBalanceStyle)
                          else
                            Text("Balanced", style: weightBalanceStyle),
                      ]),
                      SizedBox(height: 50.0),
                  ]
                )),
                SizedBox(height: 50.0),
                Column(
                  children: [
                    WaveSlider(onChanged: (double val){
                      setState(() {
                        _personWeight = (val * 100).round();
                      });
                    }, tap: () {  },),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("40", style: weightBalanceStyle),
                          Text("120", style: weightBalanceStyle),
                  ],
                ),
                    ),
                ]),
                SizedBox(
                  height: 50.0,
                ),
                ElevatedButton(
                    child: Container(
                      height: 50.0,
                      width: 100.0,
                      child: Row(
                          children: <Widget>[
                            Text('Continue', style: TextStyle(color: Colors.black, fontSize: 16.0)),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Image(image: AssetImage("assets/icons8-right-arrow-24.png")),
                            ),
                          ]),
                    ),
                  onPressed: toSuccessPage,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
