import 'dart:async';
import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:learning_hub/course.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<List<Course>> signIn() async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'profile',
      'email',
      "https://www.googleapis.com/auth/classroom.courses",
      "https://www.googleapis.com/auth/classroom.courses.readonly",
      "https://www.googleapis.com/auth/classroom.courses",
      "https://www.googleapis.com/auth/classroom.announcements"
    ],
  );
  final GoogleSignInAccount account = await _googleSignIn.signIn();
  final Map<String, String> headers = await account.authHeaders;

  final List<Course> courses = await getData(headers);

  courses.forEach((element) => print(element.name));

  return courses;
}

Future<List<Course>> getData(Map<String, String> headers) async {
  http.Response response = await http.get(
      Uri.encodeFull("https://classroom.googleapis.com/v1/courses"),
      headers: headers);

  final responseBody = response.body;

  return compute(parseCourses, responseBody);
}

List<Course> parseCourses(String responseBody) {
  var data = json.decode(responseBody);
  var courses = data["courses"] as List;
  var courseList = <Course>[];

  courses.forEach((details) {
    courseList.add(Course.fromJson(details));
  });

  courseList.forEach((course) {});

  return courseList;
}

void signOut() async {
  googleSignIn.signOut();
}
