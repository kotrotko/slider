import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check, size: 40.0,),
            SizedBox(height: 25.0),
            Text("You're all set", style: TextStyle(color: Colors.black, fontSize: 20.0),),
            SizedBox(height: 25.0),
            Text("You can now start to use the app with all the features", style: TextStyle(color: Colors.grey, fontSize: 16.0), textAlign: TextAlign.center),
            SizedBox(height: 50.0),
            TextButton(
              child: Container(
                height: 50.0,
                width: 100.0,
                child: Center(child: Text('Continue', style: TextStyle(color: Color(0xFF07489C), fontSize: 16.0))),
              ),
              onPressed: (){},
            ),
      ]),
      ));
  }
}