class MusicItem {
  final String name;
  final String url;
  final String author;
  final String preview;

  MusicItem(
      {required this.name,
      required this.url,
      required this.author,
      required this.preview});

  factory MusicItem.fromJson(Map<String, dynamic> map) {
    return MusicItem(
        name: map['name'] ?? '',
        url: map['url'] ?? '',
        author: map['author'] ?? '',
        preview: map['preview'] ?? '');
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['name'] = name;
    map['url'] = url;
    map['author'] = author;
    map['preview'] = preview;
    return map;
  }
}
