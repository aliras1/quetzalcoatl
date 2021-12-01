class User{
  int userId;
  String username;
  List<dynamic> roles;

  User({required this.userId, required this.username, required this.roles});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      roles: json['roles'],
      username: json['username'],
    );
  }

  bool isAdmin(){
    return roles.contains('ROLE_ADMIN');
  }
}
