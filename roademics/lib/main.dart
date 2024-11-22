import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/presentation/authentication/bloc/login_bloc.dart';
import 'package:roademics/presentation/authentication/pages/login_page.dart';
import 'package:roademics/presentation/authentication/pages/welcome_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          // Configuración del tema principal con la fuente Raleway
          fontFamily: 'Raleway',
          textTheme: const TextTheme(
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontFamily: 'Raleway'),
            ),
          ),
        ),
        home: const WelcomePage(),
        routes: {
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}
