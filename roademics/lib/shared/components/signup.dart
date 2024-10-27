import 'package:flutter/material.dart';
import 'package:roademics/data/authentication/repository/auth_repository_impl.dart';
import 'package:roademics/domain/authentication/repositories/auth_repository.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthRepository _authRepository = AuthRepositoryImpl(); // Añadido
  bool _acceptedTerms = false;

  Future<void> _handleSignUp() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final roles = ['ROLE_USER']; // Rol básico de ejemplo

    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept the terms and conditions")),
      );
      return;
    }

    if (password != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    try {
      await _authRepository.signUp(username, password, roles);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful")),
      );
      Navigator.pop(context); // Vuelve a la pantalla de login
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${error.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Signup"),
          backgroundColor: const Color(0xFFF0FFFF)),
      backgroundColor: const Color(0xFFF0FFFF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Roademics",
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C3350),
                fontFamily: 'Raleway',
              ),
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
                hintText: "Username",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF5F9EA0)),
                ),
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
                hintText: "Password",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF5F9EA0)),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                hintText: "Confirm Password",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF5F9EA0)),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: _acceptedTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      _acceptedTerms = value!;
                    });
                  },
                ),
                const Text("I accept the terms and conditions"),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handleSignUp,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF5F9EA0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text('SIGN UP'),
            ),
          ],
        ),
      ),
    );
  }
}
