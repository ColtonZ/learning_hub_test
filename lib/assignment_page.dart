import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_page.dart';
import 'assignment.dart';

class AssignmentPage extends StatefulWidget {
  final GoogleSignInAccount account;
  final Assignment assignment;

  AssignmentPage({this.account, this.assignment});

  @override
  AssignmentPageState createState() => AssignmentPageState();
}

class AssignmentPageState extends State<AssignmentPage> {
  GoogleSignInAccount account;
  Assignment assignment;

  void _pushHomePage(GoogleSignInAccount account) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => HomePage(
                account: account,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    account = widget.account;
    assignment = widget.assignment;
    assignment.output();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Assignment",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              _pushHomePage(account);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                "${assignment.title}",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(
                "${assignment.description}",
                style: TextStyle(fontFamily: 'Raleway'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.cloud_upload),
        backgroundColor: Colors.purpleAccent[900],
      ),
    );
  }
}
