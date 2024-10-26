import 'package:flutter/material.dart';
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
            title: Text("En General"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text("Información Personal"),
                  onTap: null, // Agrega página aquí
                ),
                ListTile(
                  title: Text("Apariencia"),
                  onTap: null, // Agrega página aquí
                ),
                ListTile(
                  title: Text("Preferencias"),
                  onTap: null, // Agrega página aquí
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
                  title: Text("Preferencias de Visibilidad"),
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
            title: Text("Privacidad de Cuenta"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text("Gestión de Datos"),
                  onTap: null, // Agrega página aquí
                ),
                ListTile(
                  title: Text("Preferencias de Visibilidad"),
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
            title: Text("Seguridad"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text("Medios de Recuperación"),
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