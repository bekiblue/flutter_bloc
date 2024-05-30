import 'package:agazh/domain/auth/user_model.dart';
import 'package:agazh/infrastructure/auth/auth_datasource.dart';

class AuthRepository {

  AuthRepository._();

  static final singleton = AuthRepository._();

  factory AuthRepository() {
    return singleton;
  }

  AuthDataSource authDataSource = AuthDataSource();

  Future<String> login(String username, String password) {
    return authDataSource.login(username, password);
  }

  register(String username, String email, String password, Role role) {
    return authDataSource.register(username, email, password, role);
  }

  Future<User> getMe(String token) async {
    return await authDataSource.getMe(token);
  }
}