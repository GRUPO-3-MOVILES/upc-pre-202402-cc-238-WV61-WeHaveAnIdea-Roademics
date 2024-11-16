import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/presentation/authentication/bloc/login_bloc.dart';
import 'package:roademics/presentation/authentication/bloc/login_event.dart';
import 'package:roademics/presentation/authentication/bloc/login_state.dart';
import 'package:roademics/presentation/profile/bloc/profile_bloc.dart';
import 'package:roademics/presentation/registration/bloc/signup_bloc.dart';
import 'package:roademics/presentation/registration/pages/sign_up_flow.dart';
import 'package:roademics/shared/presentation/bloc/password_hudden_cubit.dart';
import 'package:roademics/shared/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PasswordHiddenCubit>(
      create: (context) => PasswordHiddenCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Welcome: ${state.user.username}')),
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              } else if (state is LoginError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Roademics",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A3D62),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Correo electrónico o usuario',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  BlocBuilder<PasswordHiddenCubit, bool>(
                    builder: (context, isPasswordHidden) {
                      return TextField(
                        obscureText: isPasswordHidden,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(),
                          labelText: 'Contraseña',
                          suffixIcon: IconButton(
                            onPressed: () => context
                                .read<PasswordHiddenCubit>()
                                .togglePasswordVisibility(),
                            icon: Icon(
                              isPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final String username = _usernameController.text;
                        final String password = _passwordController.text;
                        context.read<LoginBloc>().add(
                              LoginSubmitted(
                                username: username,
                                password: password,
                              ),
                            );
                      },
                      child: const Text('Log In'),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider<SignupBloc>(
                                create: (_) => SignupBloc(),
                              ),
                              BlocProvider<ProfileBloc>(
                                create: (_) => ProfileBloc(),
                              ),
                            ],
                            child: const SignUpFlowPage(),
                          ),
                        ),
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
