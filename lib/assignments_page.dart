import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learning_hub/assignment.dart';
import 'package:learning_hub/course.dart';
import 'package:learning_hub/home_page.dart';
import 'backend.dart';

class AssignmentsPage extends StatefulWidget {
  final Course course;
  final GoogleSignInAccount account;

  AssignmentsPage({this.course, this.account});

  @override
  AssignmentsPageState createState() => AssignmentsPageState();
}

class AssignmentsPageState extends State<AssignmentsPage> {
  //Assignment _currentAssignment;

  Widget _buildAssignmentList(List<Assignment> assignments) {
    try {
      return ListView.builder(
        itemCount: (assignments.length * 2) - 1,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();
          final index = item ~/ 2;

          return _buildAssignmentRow(assignments[index]);
        },
      );
    } on NoSuchMethodError {
      return Text("You have no assignments available.");
    }
  }

  Widget _buildAssignmentRow(Assignment assignment) {
    return ListTile(
        title: Text(
          assignment.title,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          assignment.description != null
              ? assignment.description.split("\n").length > 1
                  ? assignment.description.split("\n")[0].length > 40
                      ? assignment.description
                              .split("\n")[0]
                              .substring(0, 40)
                              .trim() +
                          "..."
                      : assignment.description.split("\n")[0].trim() + "..."
                  : assignment.description.length > 40
                      ? assignment.description.substring(0, 40).trim() + "..."
                      : assignment.description.trim()
              : "This task has no description",
        ),
        onTap: () {
          setState(() {
            //_currentAssignment = assignment;
          });
        });
  }

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
    Course course = widget.course;
    GoogleSignInAccount account = widget.account;

    return Scaffold(
      appBar: AppBar(
        title: Text("Assignments for ${course.name}"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              _pushHomePage(account);
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: getAssignments(course.id, account),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildAssignmentList(snapshot.data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
