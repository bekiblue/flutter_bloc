import 'package:agazh/application/auth/auth_bloc.dart';
import 'package:agazh/application/auth/auth_events.dart';
import 'package:agazh/application/auth/auth_states.dart';
import 'package:agazh/domain/auth/user_model.dart';
import 'package:agazh/presentation/auth/login_screen.dart';
import 'package:agazh/presentation/job/job_list_screen.dart';
import 'package:agazh/presentation/job_application/job_application_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var role = Role.freelancer;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is AuthSuccessState){
          if(state.user.role == Role.freelancer){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const JobListScreen()));
          }else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const JobApplicationListScreen()));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Register'),
            ),
            body: Center(
              child: Column(
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  DropdownButton(
                    value: role,
                    onChanged: (value) {
                      setState(() {
                        role = value as Role;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: Role.freelancer,
                        child: Text('Freelancer'),
                      ),
                      DropdownMenuItem(
                        value: Role.client,
                        child: Text('client'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        RegisterEvent(
                            username: usernameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            role: role),
                      );
                    },
                    child: const Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text('Login'),
                  )
                ],
              ),
            ));
      },
    );
  }
}
