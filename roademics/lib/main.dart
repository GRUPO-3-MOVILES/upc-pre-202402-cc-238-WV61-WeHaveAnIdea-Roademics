import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/presentation/authentication/bloc/login_bloc.dart';
import 'package:roademics/presentation/authentication/pages/login_page.dart';
import 'package:roademics/presentation/authentication/pages/welcome_page.dart';
import 'package:roademics/presentation/profile/bloc/profile_bloc.dart';
import 'package:roademics/presentation/registration/bloc/signup_bloc.dart';
import 'package:roademics/presentation/registration/pages/sign_up_flow.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Roademics',
        theme: ThemeData(
          // Configuración del tema principal con la fuente Raleway
          fontFamily: 'Raleway',
          textTheme: const TextTheme(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                  fontFamily: 'Raleway', fontWeight: FontWeight.bold),
            ),
          ),
        ),
        home: const WelcomePage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpFlowPage(),
        },
      ),
    );
  }
}
