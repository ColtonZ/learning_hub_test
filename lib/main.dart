import 'package:flutter/material.dart';
import 'classroom.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBase',
      home: Scaffold(
        appBar: AppBar(
          title: Text('FlutterBase'),
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                onPressed: () => getData,
                color: Colors.white,
                textColor: Colors.black,
                child: Text('Get Data'),
              ),
              MaterialButton(
                onPressed: () => null,
                color: Colors.red,
                textColor: Colors.black,
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
