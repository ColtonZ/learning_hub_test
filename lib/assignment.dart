class Assignment {
  final String title;
  final String description;
  final String id;
  final String status;

  Assignment({this.id, this.title, this.description, this.status});

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      status: json["state"],
    );
  }

  void output() {
    print(
        "ID: $id | Title: $title | Description: $description | Status: $status");
  }
}
