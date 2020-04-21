import 'package:flutter/material.dart';
import 'classroom.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull("https://classroom.googleapis.com/v1/courses"),
        headers: {
          "key": "AIzaSyBZ5izrPKmflMeDuGiJbZ0eudN1FD3OU1o",
          "Accept": "application/json"
        });

    print(response.body);
  }

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
                onPressed: getData,
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
