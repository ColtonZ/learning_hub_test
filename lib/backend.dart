import 'dart:async';
import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:learning_hub/assignment.dart';
import 'package:learning_hub/course.dart';
import 'assignment_material.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<GoogleSignInAccount> signIn() async {
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

  return account;
}

Future<Map<String, String>> getHeaders(GoogleSignInAccount account) async {
  final Map<String, String> headers = await account.authHeaders;

  return headers;
}

Future<List<Course>> getCourses(GoogleSignInAccount account) async {
  Map<String, String> headers;

  if (isSignedIn(account)) {
    headers = await getHeaders(account);
  } else {
    headers = await getHeaders(await signIn());
  }

  final List<Course> courses = await sendCourseRequest(headers);

  return courses;
}

Future<List<Course>> sendCourseRequest(Map<String, String> headers) async {
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
    if (course.status == "ACTIVE") {
      courseList.add(course);
    }
  });

  return courseList;
}

Future<List<Assignment>> getAssignments(
    String id, GoogleSignInAccount account) async {
  Map<String, String> headers;
  if (isSignedIn(account)) {
    headers = await getHeaders(account);
  } else {
    headers = await getHeaders(await signIn());
  }
  final List<Assignment> assignments = await sendAssignmentRequest(id, headers);
  return assignments;
}

Future<List<Assignment>> sendAssignmentRequest(
    String id, Map<String, String> headers) async {
  http.Response response = await http.get(
      Uri.encodeFull(
          "https://classroom.googleapis.com//v1/courses/$id/courseWork"),
      headers: headers);

  final responseBody = response.body;
  return compute(parseAssignments, responseBody);
}

List<Assignment> parseAssignments(String responseBody) {
  var data = json.decode(responseBody);
  var assignments = data["courseWork"] as List;
  var assignmentList = <Assignment>[];

  assignments.forEach((details) {
    Assignment assignment = Assignment.fromJson(details);
    assignmentList.add(assignment);
    assignment.output();
  });

  return assignmentList;
}

List<Material> getMaterials(String responseBody) {
  var data = json.decode(responseBody);
  var materials = data["materials"] as List;
  var materialsList = <Material>[];

  materials.forEach((details) {
    Material material = Material.fromJson(details);
    materialsList.add(material);
  });

  return materialsList;
}

bool isSignedIn(GoogleSignInAccount account) {
  if (account != null) {
    return true;
  } else {
    return false;
  }
}

Future<GoogleSignInAccount> signOut() async {
  googleSignIn.signOut();
  return null;
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
