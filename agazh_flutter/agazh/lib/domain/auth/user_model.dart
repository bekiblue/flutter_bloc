class User {
  int id;
  String username, email;
  Role role;

  User({
    this.id = 0,
    required this.username,
    required this.email,
    required this.role,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: json['role'] == 'client' ? Role.client : Role.freelancer,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role == Role.client ? 'client' : 'freelancer',
    };
  }
}

enum Role { client, freelancer }
