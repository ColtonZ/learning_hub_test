import 'package:flutter/material.dart';
import 'package:learning_hub_test/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primaryColor: Colors.deepPurpleAccent, fontFamily: 'Cabin'),
      home: HomePage(),
    );
  }
}
