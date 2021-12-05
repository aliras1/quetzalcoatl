class CaffFile{
  int id;
  String title;

  CaffFile({required this.id, required this.title});

  factory CaffFile.fromJson(Map<String, dynamic> json) {
    return CaffFile(
      id: json['id'],
      title: json['title'],
    );
  }
}
