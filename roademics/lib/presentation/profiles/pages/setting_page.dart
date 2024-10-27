import 'package:flutter/material.dart';
import 'package:roademics/presentation/profiles/pages/change_password_page.dart';
import 'package:roademics/presentation/profiles/pages/email_addresses_page.dart';
import 'package:roademics/presentation/profiles/pages/phone_numbers_page.dart';
import 'package:roademics/presentation/profiles/widgets/nav_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajustes de usuario"),
        backgroundColor: const Color(0xFFF0FFFF),
      ),
      body: ListView(
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
              // Agregar funcionalidad de eliminación de cuenta aquí
            },
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(), // Añade el NavBar
    );
  }
}