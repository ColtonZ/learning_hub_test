import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learning_hub_test/assignment.dart';
import 'package:learning_hub_test/course.dart';
import 'package:learning_hub_test/home_page.dart';
import 'assignment_page.dart';
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

  Widget _buildAssignmentList(
      GoogleSignInAccount account, List<Assignment> assignments) {
    try {
      return ListView.builder(
        itemCount: (assignments.length * 2) - 1,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();
          final index = item ~/ 2;

          return _buildAssignmentRow(account, assignments[index]);
        },
      );
    } on NoSuchMethodError {
      return Center(
        child: Text(
          "You have no assignments available.",
          style: TextStyle(
            fontFamily: 'Raleway',
          ),
        ),
      );
    }
  }

  Widget _buildAssignmentRow(
      GoogleSignInAccount account, Assignment assignment) {
    return ListTile(
        title: Text(
          assignment.title != null ? assignment.title : "N/A",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          (assignment.description != null
                  ? assignment.description.split("\n").length > 1
                      ? assignment.description.split("\n")[0].length > 40
                          ? assignment.description
                                  .split("\n")[0]
                                  .substring(0, 40)
                                  .trim() +
                              "..."
                          : assignment.description.split("\n")[0].trim() + "..."
                      : assignment.description.length > 40
                          ? assignment.description.substring(0, 40).trim() +
                              "..."
                          : assignment.description.trim()
                  : "This task has no description") +
              "\nType: ${assignment.type == "ASSIGNMENT" ? "Assignment" : assignment.type == "SHORT_ANSWER_QUESTION" ? "Short Answer Question" : assignment.type == "MULTIPLE_CHOICE_QUESTION" ? "Multiple Choice Question" : assignment.type}",
          style: TextStyle(
            fontFamily: 'Raleway',
          ),
        ),
        trailing: Icon(assignment.type == "ASSIGNMENT"
            ? Icons.assignment
            : assignment.type == "SHORT_ANSWER_QUESTION"
                ? Icons.short_text
                : assignment.type == "MULTIPLE_CHOICE_QUESTION"
                    ? Icons.check_circle_outline
                    : Icons.warning),
        isThreeLine: true,
        leading: null,
        onTap: () {
          _viewAssignment(account, assignment);
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

  void _viewAssignment(GoogleSignInAccount account, Assignment assignment) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => AssignmentPage(
                account: account,
                assignment: assignment,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    Course course = widget.course;
    GoogleSignInAccount account = widget.account;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Assignments for ${course.name}",
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
      body: FutureBuilder(
          future: getAssignments(course.id, account),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildAssignmentList(account, snapshot.data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
