class CaffFile{
  int caffId;
  String name;

  CaffFile({required this.caffId, required this.name});

  factory CaffFile.fromJson(Map<String, dynamic> json) {
    return CaffFile(
      caffId: json['caffId'],
      name: json['name'],
    );
  }
}
