class User {
  String username, email;
  Role role;

  User(
      {required this.username,
      required this.email,
      required this.role});

  static User fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      role: json['role'] == 'client' ? Role.client : Role.freelancer,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'role': role == Role.client ? 'client' : 'freelancer',
    };
  }
}

enum Role { client, freelancer }
