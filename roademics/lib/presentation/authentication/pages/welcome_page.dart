import 'package:flutter/material.dart';
import 'package:roademics/presentation/authentication/pages/login_page.dart';
import 'package:roademics/presentation/registration/pages/sign_up_flow.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/welcome_logo.png', // Cambia por la ruta de tu imagen
              fit: BoxFit.cover,
            ),
          ),
          // Contenido principal
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32.0),
                const Text(
                  "Welcome to Roademics",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A3D62), // Cambia según el contraste necesario
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Botón de Login
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text('Log In'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A3D62), // Color de fondo del botón de Login
                          foregroundColor: Colors.white, // Color del texto del botón
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          textStyle: const TextStyle(fontSize: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0), // Borde redondeado
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Botón de Sign Up
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpFlowPage(),
                            ),
                          );
                        },
                        child: const Text('Create Account'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: Color(0xFF0A3D62), width: 2.0), 
                                foregroundColor: Color(0xFF0A3D62),// Borde del botón
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          textStyle: const TextStyle(fontSize: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0), // Borde redondeado
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
