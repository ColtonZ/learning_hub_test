import 'package:flutter/material.dart';
import 'package:learning_hub/courses_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
      home: CoursesPage(),
    );
  }
}
