import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['profile', 'email', "https://www.googleapis.com/auth/classroom.courses", "https://www.googleapis.com/auth/classroom.courses.readonly"],
  );
  final GoogleSignInAccount account = await _googleSignIn.signIn();
  print("Account details: $account");
}
