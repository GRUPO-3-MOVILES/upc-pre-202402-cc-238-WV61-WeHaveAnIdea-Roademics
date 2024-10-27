import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/presentation/profiles/bloc/profile_bloc.dart';
import 'package:roademics/presentation/profiles/bloc/profile_event.dart';
import 'package:roademics/presentation/profiles/widgets/nav_bar.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late ProfileBloc _profileBloc;
  bool isPasswordValid = false;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  void _validatePassword(String value) {
    setState(() {
      isPasswordValid = value.length >= 8 &&
          RegExp(r'[a-z]').hasMatch(value) &&
          RegExp(r'[A-Z]').hasMatch(value) &&
          RegExp(r'\d').hasMatch(value) &&
          RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cambio de Contraseña"),
        backgroundColor: const Color(0xFFF0FFFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _currentPasswordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña Actual',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(
                labelText: 'Nueva Contraseña',
              ),
              obscureText: true,
              onChanged: _validatePassword,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirmar Nueva Contraseña',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isPasswordValid ? () {
                if (_newPasswordController.text == _confirmPasswordController.text) {
                  _profileBloc.add(UpdatePassword(
                    currentPassword: _currentPasswordController.text,
                    newPassword: _newPasswordController.text,
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Las contraseñas no coinciden'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5F9EA0),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                foregroundColor: Colors.white,
              ),
              child: const Text('Guardar Contraseña'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}