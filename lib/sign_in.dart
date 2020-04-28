import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<Map<String, String>> getData() async {
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

  print("Account details: $account");

  http.Response response = await http.get(
      Uri.encodeFull("https://classroom.googleapis.com/v1/courses"),
      headers: headers);

  print(response.body);

  return account.authHeaders;
}
