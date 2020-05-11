import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:learning_hub/course.dart';
import 'package:learning_hub/assignments_page.dart';
import 'backend.dart';

class CoursesPage extends StatefulWidget {
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
          print(item);
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
              )),
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
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
          future: signInAndGetCourses(),
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
