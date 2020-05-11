import 'dart:async';
import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:learning_hub/assignment.dart';
import 'package:learning_hub/course.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<Map<String, String>> signIn() async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'profile',
      'email',
      "https://www.googleapis.com/auth/classroom.courses",
      "https://www.googleapis.com/auth/classroom.courses.readonly",
      "https://www.googleapis.com/auth/classroom.courses",
      "https://www.googleapis.com/auth/classroom.announcements",
      "https://www.googleapis.com/auth/classroom.coursework.me.readonly"
    ],
  );
  final GoogleSignInAccount account = await _googleSignIn.signIn();
  final Map<String, String> headers = await account.authHeaders;

  return headers;
}

Future<List<Course>> signInAndGetCourses() async {
  Map<String, String> headers = await signIn();

  final List<Course> courses = await getCourses(headers);

  courses.forEach((element) => print(element.name));

  return courses;
}

Future<List<Course>> getCourses(Map<String, String> headers) async {
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
    Course course = Course.fromJson(details);
    print("$details");
    course.output();
    if (course.status == "ACTIVE") {
      courseList.add(course);
    }
  });

  courseList.forEach((course) {});

  return courseList;
}

Future<List<Assignment>> getAssignments(String id) async {
  Map<String, String> headers = await signIn();

  http.Response response = await http.get(
      Uri.encodeFull(
          "https://classroom.googleapis.com//v1/courses/$id/courseWork"),
      headers: headers);

  final responseBody = response.body;

  print(responseBody);

  return compute(parseAssignments, responseBody);
}

List<Assignment> parseAssignments(String responseBody) {
  var data = json.decode(responseBody);
  var assignments = data["courseWork"] as List;
  var assignmentList = <Assignment>[];

  assignments.forEach((details) {
    Assignment assignment = Assignment.fromJson(details);
    print("$details");
    assignment.output();
    assignmentList.add(assignment);
  });

  assignmentList.forEach((course) {});

  return assignmentList;
}

void signOut() async {
  googleSignIn.signOut();
}
