import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learning_hub_test/courses_page.dart';
import 'backend.dart';

class HomePage extends StatefulWidget {
  final GoogleSignInAccount account;

  HomePage({this.account});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  GoogleSignInAccount account;

  void _pushCoursesPage(GoogleSignInAccount account) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => CoursesPage(
                account: widget.account,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    account = widget.account;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Account"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.swap_horiz),
              onPressed: () {
                signOut();
                setState(() {
                  account = null;
                });
              }),
        ],
      ),
      body: account != null
          ? Text("Signed in!")
          : FutureBuilder(
              future: signIn(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  account = snapshot.data;
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Account Name:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${account.displayName}",
                          style: TextStyle(
                              fontSize: 38, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            account.photoUrl,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          onPressed: () => _pushCoursesPage(account),
                          child: Text("View your courses"),
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
    );
  }
}
