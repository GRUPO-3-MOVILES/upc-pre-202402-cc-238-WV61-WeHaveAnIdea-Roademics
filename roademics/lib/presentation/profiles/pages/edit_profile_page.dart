import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/presentation/profiles/bloc/profile_bloc.dart';
import 'package:roademics/data/profiles/repository/profile_repository_impl.dart';
import 'package:roademics/data/profiles/remote/profile_service.dart';
import 'package:roademics/presentation/profiles/pages/profile_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controladores para los campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Aquí puedes inicializar los controladores con los valores actuales del perfil
    _nameController.text = "Reemplazar con el nombre actual"; // Reemplaza con el valor actual del nombre
    _cityController.text = "Reemplazar con la ciudad actual"; // Reemplaza con el valor actual de la ciudad
    _bioController.text = "Reemplazar con la biografía actual"; // Reemplaza con el valor actual de la biografía
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileBloc(profileRepository: ProfileRepositoryImpl(ProfileService())),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF0FFFF),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0C3350)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Edit", style: TextStyle(color: Color(0xFF0C3350))),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _bioController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Biography",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Acción para guardar los cambios del perfil
                    final newName = _nameController.text;
                    final newCity = _cityController.text;
                    final newBio = _bioController.text;
                    
                    // Aquí puedes llamar a tu Bloc o servicio para guardar los cambios
                    print("Nombre: $newName, Ciudad: $newCity, Biografía: $newBio");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5F9EA0),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
