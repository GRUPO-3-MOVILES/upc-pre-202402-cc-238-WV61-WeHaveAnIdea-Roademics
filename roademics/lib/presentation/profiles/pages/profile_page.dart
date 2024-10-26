import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/presentation/profiles/bloc/profile_bloc.dart';
import 'package:roademics/data/profiles/repository/profile_repository_impl.dart';
import 'package:roademics/data/profiles/remote/profile_service.dart';
import 'package:roademics/presentation/profiles/bloc/profile_event.dart';
import 'package:roademics/presentation/profiles/bloc/profile_state.dart';
import 'package:roademics/presentation/profiles/pages/setting_page.dart';
import 'package:roademics/presentation/profiles/widgets/nav_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(profileRepository: ProfileRepositoryImpl(ProfileService())), // Usa el repositorio
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: const Color(0xFFF0FFFF),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()), // Navega a SettingsPage
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial) {
              context.read<ProfileBloc>().add(LoadProfile());
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              final profile = state.profile;
              final personalInfo = profile.personalInformation;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: const Color(0xFFFFFFFF),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/img/profile.png'),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              personalInfo.personName.firstName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              profile.profileType,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              '${personalInfo.address.city}, ${personalInfo.address.country}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black38,
                              ),
                            ),
                            const Text(
                              '180 Followers',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Acción al presionar "Editar Perfil"
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5F9EA0),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Editar Perfil'),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Acción al presionar "Mis Roadmaps"
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5F9EA0),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Mis Roadmaps'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return const Center(child: Text("No se encontraron datos"));
          },
        ),
        bottomNavigationBar: const NavBar(), // Añade el NavBar
      ),
    );
  }
}