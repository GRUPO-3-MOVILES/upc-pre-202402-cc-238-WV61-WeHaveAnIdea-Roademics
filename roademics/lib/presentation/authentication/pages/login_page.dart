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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 3, 37, 37), 
              Color.fromARGB(255, 7, 32, 78),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
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
                  // Imagen añadida
                  Image.asset(
                    'assets/Roademics_logo.png', // Ruta de tu imagen en assets
                    height: 200, // Ajusta el tamaño según lo necesites
                  ),
                  const SizedBox(height: 4), // Espaciado entre imagen y título
                  const Text(
                    "Roademics",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  BlocBuilder<PasswordHiddenCubit, bool>(
                    builder: (context, isPasswordHidden) {
                      return TextField(
                        obscureText: isPasswordHidden,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock, color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.5),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          suffixIcon: IconButton(
                            onPressed: () => context
                                .read<PasswordHiddenCubit>()
                                .togglePasswordVisibility(),
                            icon: Icon(
                              isPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        // Acción para "Forgot my password"
                      },
                      child: const Text(
                        'Forgot my password',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 9, 50, 75), // Color del botón
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
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
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
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
                    child: const Text(
                      'New member? Create an account',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}