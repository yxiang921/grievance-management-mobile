class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String? phone_number;
  final String password;
  final String? avatar;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone_number,
    required this.password,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone_number: json['phone_number'],
      password: json['password'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone_number': phone_number,
      'password': password,
      'avatar': avatar,
    };
  }
}
