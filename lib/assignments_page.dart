import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:learning_hub/assignment.dart';
import 'package:learning_hub/course.dart';
import 'package:learning_hub/courses_page.dart';
import 'backend.dart';

class AssignmentsPage extends StatefulWidget {
  final Course course;

  AssignmentsPage({this.course});

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
          print(item);
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
        onTap: () {
          setState(() {
            //_currentAssignment = assignment;
          });
        });
  }

  void _pushSignInScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Sign In"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.class_),
                  onPressed: () {
                    signIn();
                    return CoursesPageState;
                  },
                ),
              ],
            ),
            body: Text("Sign In!"),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Course course = widget.course;

    return Scaffold(
      appBar: AppBar(
        title: Text("Assignments"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              signOut();
              _pushSignInScreen();
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: getAssignments(course.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildAssignmentList(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

//TODO: Do the bit above to get the assignments from a specific course, given the id
