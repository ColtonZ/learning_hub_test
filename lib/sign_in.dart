import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  await _googleSignIn.signIn();
}

//https://medium.com/flutter-community/flutter-sign-in-with-google-in-android-without-firebase-a91b977d166f
