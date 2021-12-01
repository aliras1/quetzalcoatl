class AuthUser {
  int id;
  String username;
  String password;

  AuthUser({required this.id, required this.username, required this.password});

  AuthUser.fromMap(Map<String, dynamic> res)
      : username = res["username"],
        id = res["id"],
        password = res["password"];

  Map<String, Object?> toMap() {
    return {'username': username, 'password': password, 'id': id};
  }
}
