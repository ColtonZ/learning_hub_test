import 'dart:async';

import 'package:http/http.dart' as http;

Future<String> getData() async {
  var response = await http.get(
      Uri.encodeFull("https://classroom.googleapis.com/v1/courses"),
      headers: {"key": ""});
}
