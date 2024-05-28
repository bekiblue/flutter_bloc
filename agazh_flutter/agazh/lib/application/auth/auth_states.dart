import 'package:agazh/domain/auth/user_model.dart';

class AuthState {}

class AuthIitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState({required this.message});
}

class AuthSuccessState extends AuthState {
  final String token;
  final User user;

  AuthSuccessState({required this.token, required this.user});
}
