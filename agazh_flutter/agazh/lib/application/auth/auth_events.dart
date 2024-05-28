import 'package:agazh/domain/auth/user_model.dart';

class AuthEvent {}

class AuthIitilizeEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final Role role;

  RegisterEvent(
      {required this.username,
      required this.email,
      required this.password,
      required this.role});
}

class LogoutEvent extends AuthEvent {}