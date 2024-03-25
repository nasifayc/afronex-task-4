class User {
  final String username;
  final String email;
  final String password;
  String? imgUrl;

  User(
      {required this.username,
      required this.email,
      required this.password,
      this.imgUrl});

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        email: json['email'],
        password: json['password'],
        imgUrl: json['imgUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'imgUrl': imgUrl
    };
  }
}
