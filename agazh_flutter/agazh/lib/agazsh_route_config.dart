import 'package:agazh/main.dart';
import 'package:agazh/presentation/auth/screens/login_screen.dart';
import 'package:agazh/presentation/auth/screens/register_screen.dart';
import 'package:agazh/presentation/job/client_home_screen.dart';
import 'package:agazh/presentation/job_application/freelancer_home_screen.dart';
import 'package:go_router/go_router.dart';

class PathName {
  static String splash = "/";
  static String register = '/register';
  static String logIn = '/log_in';
  static String client = '/client';
  static String freelancer = '/freelancer';
}

class AgazshRoute {
  GoRouter router = GoRouter(routes: [
    GoRoute(
      path: PathName.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: PathName.register,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: PathName.logIn,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: PathName.client,
      builder: (context, state) => ClientHomeScreen(),
    ),
    GoRoute(
      path: PathName.freelancer,
      builder: (context, state) => FreelancerHomeScreen(),
    )
  ]);
}
