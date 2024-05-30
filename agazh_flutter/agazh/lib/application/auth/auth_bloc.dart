import 'package:agazh/application/auth/auth_events.dart';
import 'package:agazh/application/auth/auth_states.dart';
import 'package:agazh/domain/auth/user_model.dart';
import 'package:agazh/infrastructure/auth/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository = AuthRepository();

  static final AuthBloc _singleton = AuthBloc._();

  factory AuthBloc() {
    return _singleton;
  }

  AuthBloc._() : super(AuthIitialState()) {
    on<LoginEvent>(loginHandler);
    on<RegisterEvent>(registerHandler);
    on<AuthInitializeEvent>(initializeHandler);
    on<LogoutEvent>(logoutHandler);
  }

  logoutHandler(event, emit) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    emit(AuthIitialState());
  }

  initializeHandler(event, emit) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token != null) {
      try {
        User user = await authRepository.getMe(token);
        emit(AuthSuccessState(token: token, user: user));
      } catch (e) {
        emit(AuthErrorState(message: e.toString()));
      }
    } else {
      emit(AuthIitialState());
    }
  }

  registerHandler(event, emit) async {
    emit(AuthLoadingState());
    try {
    
      await authRepository.register(
          event.username, event.email, event.password, event.role);

      var token = await authRepository.login(event.username, event.password);
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      User user = await authRepository.getMe(token);
      emit(AuthSuccessState(token: token, user: user));
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
    }
  }

  loginHandler(event, emit) async {
    emit(AuthLoadingState());
    try {
      var token = await authRepository.login(event.email, event.password);
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      User user = await authRepository.getMe(token);
      emit(AuthSuccessState(token: token, user: user));
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
    }
  }
}
