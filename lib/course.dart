import 'assignment.dart';

class Course {
  final String name;
  final String description;
  final String platform;
  final String id;
  final assignments = <Assignment>[];

  Course({this.platform, this.id, this.name, this.description});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      platform: "Google Classroom",
      id: json["id"],
      name: json["name"],
      description: json["descriptionHeading"],
    );
  }

  void output() {
    print(
        "Platform: $platform | ID: $id | Name: $name | Description: $description");
  }
}
