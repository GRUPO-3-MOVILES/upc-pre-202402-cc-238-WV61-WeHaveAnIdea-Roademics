import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/presentation/profiles/bloc/profile_bloc.dart';
import 'package:roademics/presentation/profiles/bloc/profile_event.dart';
import 'package:roademics/presentation/profiles/bloc/profile_state.dart';
import 'package:roademics/presentation/profiles/widgets/nav_bar.dart';

class EmailAddressesPage extends StatefulWidget {
  const EmailAddressesPage({super.key});

  @override
  EmailAddressesPageState createState() => EmailAddressesPageState();
}

class EmailAddressesPageState extends State<EmailAddressesPage> {
  late ProfileBloc _profileBloc;
  String email = "";
  bool isEditing = false;
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Direcciones de Correo Electrónico"),
        backgroundColor: const Color(0xFFF0FFFF),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial || state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            email = state.profile.email;
            _emailController.text = email;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Correo Electrónico Actual: $email"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5F9EA0),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(isEditing ? 'Guardar Dirección de Correo Electrónico' : 'Cambiar Dirección de Correo Electrónico'),
                  ),
                  if (isEditing) ...[
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Nuevo Correo Electrónico',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text("Error: ${state.error}"));
          }
          return const Center(child: Text("No se encontraron datos"));
        },
      ),
      bottomNavigationBar: const NavBar(), 
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}