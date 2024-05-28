import 'package:agazh/application/auth/auth_bloc.dart';
import 'package:agazh/application/auth/auth_events.dart';
import 'package:agazh/application/auth/auth_states.dart';
import 'package:agazh/domain/auth/user_model.dart';
import 'package:agazh/presentation/auth/login_screen.dart';
import 'package:agazh/presentation/job/job_list_screen.dart';
import 'package:agazh/presentation/job_application/job_application_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AuthIitilizeEvent())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          if (state.user.role == Role.freelancer) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const JobListScreen(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const JobApplicationListScreen(),
              ),
            );
          }
        } else if (state is AuthErrorState || state is AuthIitialState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      },
      child: const Scaffold(
        body: Center(
          child: Text(
            "Agazh",
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
