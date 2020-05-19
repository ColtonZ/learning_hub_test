import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learning_hub/course.dart';
import 'package:learning_hub/assignments_page.dart';
import 'package:learning_hub/home_page.dart';
import 'backend.dart';

class CoursesPage extends StatefulWidget {
  final GoogleSignInAccount account;

  CoursesPage({this.account});

  @override
  CoursesPageState createState() => CoursesPageState();
}

class CoursesPageState extends State<CoursesPage> {
  Course _currentCourse;

  Widget _buildCourseList(List<Course> courses) {
    try {
      return ListView.builder(
        itemCount: (courses.length * 2) - 1,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();
          final index = item ~/ 2;

          return _buildCourseRow(courses[index]);
        },
      );
    } on NoSuchMethodError {
      return Text("You have no courses available.");
    }
  }

  Widget _buildCourseRow(Course course) {
    return ListTile(
        title: Text(
          course.name,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          course.description == course.name ? "" : course.description,
        ),
        onTap: () {
          setState(() {
            _currentCourse = course;
            _pushCurrentCourse(_currentCourse);
          });
        });
  }

  void _pushCurrentCourse(Course course) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => AssignmentsPage(
                course: course,
                account: widget.account,
              )),
    );
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
    GoogleSignInAccount account = widget.account;

    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              if (isSignedIn(account)) {
                signOut();
              }
              _pushHomePage(account);
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: getCourses(account),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildCourseList(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
