import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/presentation/profiles/bloc/profile_bloc.dart';
import 'package:roademics/presentation/profiles/bloc/profile_event.dart';
import 'package:roademics/presentation/profiles/bloc/profile_state.dart';
import 'package:roademics/presentation/profiles/pages/change_password_page.dart';
import 'package:roademics/presentation/profiles/pages/email_addresses_page.dart';
import 'package:roademics/presentation/profiles/pages/phone_numbers_page.dart';
import 'package:roademics/presentation/profiles/widgets/nav_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final TextEditingController _passwordController = TextEditingController();
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajustes de usuario"),
        backgroundColor: const Color(0xFFF0FFFF),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is AccountDeleted) {
            Navigator.of(context).pushReplacementNamed('/login'); 
          } else if (state is ProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const ListTile(
              title: Text("Preferencias de Usuario"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("Idioma"),
                    onTap: null, // Agrega página aquí
                  ),
                  ListTile(
                    title: Text("Modo Oscuro"),
                    onTap: null, // Agrega página aquí
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text("Acceso a la Cuenta"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text("Direcciones de Correo Electrónico"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EmailAddressesPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("Números de Teléfono"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PhoneNumbersPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("Cambio de Contraseña"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            const ListTile(
              title: Text("Privacidad de Cuenta"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("Gestión de Datos"),
                    onTap: null, // Agrega página aquí
                  ),
                  ListTile(
                    title: Text("Contactos"),
                    onTap: null, // Agrega página aquí
                  ),
                  ListTile(
                    title: Text("Términos de Privacidad"),
                    onTap: null, // Agrega página aquí
                  ),
                ],
              ),
            ),
            const Divider(),
            const ListTile(
              title: Text("Visibilidad"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("Visualización del Perfil"),
                    onTap: null, // Agrega página aquí
                  ),
                  ListTile(
                    title: Text("Gestionar Estado"),
                    onTap: null, // Agrega página aquí
                  ),
                  ListTile(
                    title: Text("Bloqueos"),
                    onTap: null, // Agrega página aquí
                  ),
                ],
              ),
            ),
            const Divider(),
            const ListTile(
              title: Text("Seguridad"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("Llaves de Acceso"),
                    onTap: null, // Agrega página aquí
                  ),
                  ListTile(
                    title: Text("Verificación en Dos Pasos"),
                    onTap: null, // Agrega página aquí
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text("Eliminar Cuenta"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmar Eliminación de Cuenta'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Esta acción no se puede revertir. Perderás todos tus datos. Por favor, ingresa tu contraseña para confirmar.',
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Contraseña',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _profileBloc.add(DeleteAccount(_passwordController.text));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF073248),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Eliminar Cuenta'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}