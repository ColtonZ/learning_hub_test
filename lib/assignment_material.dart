class Material {
  final String title;
  final String fileLink;
  final String thumbnail;
  final String webUrl;

  Material({this.title, this.fileLink, this.webUrl, this.thumbnail});

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      fileLink: json["alternateLink"],
      webUrl: json["link"],
      title: json["title"],
      thumbnail: json["thumbnailUrl"],
    );
  }

  void output() {
    print(
        "Title: $title | File Link: $fileLink | Web Url: $webUrl | Thumbnail: $thumbnail");
  }
}
