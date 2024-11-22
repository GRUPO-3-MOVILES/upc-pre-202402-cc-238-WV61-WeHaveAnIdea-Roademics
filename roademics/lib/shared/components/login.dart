import 'package:flutter/material.dart';
import 'package:roademics/data/authentication/repository/auth_repository_impl.dart';
import 'package:roademics/domain/authentication/repositories/auth_repository.dart';
import 'package:roademics/shared/components/home_with_user_page.dart';
import 'package:roademics/shared/components/recovery.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _RootpageState();
}

class _RootpageState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepositoryImpl(); // Añadido

  Future<void> _handleLogin() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final user = await _authRepository.signIn(username, password);
      if (!mounted) return; // Check if the widget is still mounted
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeWithUser(user: user)),
      );
    } catch (error) {
      if (!mounted) return; // Check if the widget is still mounted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${error.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFFF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Roademics",
              style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0C3350),
                  fontFamily: 'Raleway'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                hintText: "Enter your user",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF5F9EA0))),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                hintText: "Enter your password",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF5F9EA0))),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Recovery()),
                );
              },
              child: const Text(
                "Recover password",
                style: TextStyle(
                  color: Color(0xFF5F9EA0),
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF5F9EA0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text('LOG IN'),
            ),
          ],
        ),
      ),
    );
  }
}
