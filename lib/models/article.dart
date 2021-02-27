import 'dart:convert';

class Article {
  String by;
  int id;
  int time;
  String title;
  String type;
  String url;
  Article({
    this.by,
    this.id,
    this.time,
    this.title,
    this.type,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'by': by,
      'id': id,
      'time': time,
      'title': title,
      'type': type,
      'url': url,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Article(
      by: map['by'],
      id: map['id'],
      time: map['time'],
      title: map['title'],
      type: map['type'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source));
}
