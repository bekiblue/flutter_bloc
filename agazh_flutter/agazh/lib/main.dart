import 'package:agazh/agazsh_route_config.dart';
import 'package:agazh/application/auth/auth_bloc.dart';
import 'package:agazh/application/auth/auth_events.dart';
import 'package:agazh/application/auth/auth_states.dart';
import 'package:agazh/application/job/job_bloc.dart';
import 'package:agazh/application/job_application/job_application_bloc.dart';
import 'package:agazh/domain/auth/user_model.dart';
import 'package:agazh/presentation/auth/screens/login_screen.dart';
import 'package:agazh/presentation/job_application/freelancer_home_screen.dart';
import 'package:agazh/presentation/job/client_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc()..add(AuthInitializeEvent())),
        BlocProvider(create: (context) => JobBloc()..add(GetJobsEvent())),
        BlocProvider(create: (context) => JobApplicationBloc())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AgazshRoute().router,
        title: 'Agazsh',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          if (state.user.role == Role.freelancer) {
            context.go(PathName.freelancer);
          } else {
            context.go(PathName.client);
          }
        } else if (state is AuthErrorState || state is AuthIitialState) {
          context.go(PathName.logIn);
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
