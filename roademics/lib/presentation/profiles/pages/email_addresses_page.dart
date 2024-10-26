

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/data/profiles/remote/profile_service.dart';
import 'package:roademics/data/profiles/repository/profile_repository_impl.dart';
import 'package:roademics/presentation/profiles/bloc/profile_bloc.dart';
import 'package:roademics/presentation/profiles/bloc/profile_event.dart';
import 'package:roademics/presentation/profiles/bloc/profile_state.dart';
import 'package:roademics/presentation/profiles/widgets/nav_bar.dart';

class EmailAddressesPage extends StatefulWidget {
  const EmailAddressesPage({super.key});

  @override
  EmailAddressesPageState createState() => EmailAddressesPageState();
}

class    EmailAddressesPageState extends State<EmailAddressesPage> {
  late TextEditingController _emailController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(profileRepository: ProfileRepositoryImpl(ProfileService())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Direcciones de Correo Electrónico"),
          backgroundColor: const Color(0xFFF0FFFF),
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
              return Column(
                children: [
                  ListTile(
                    title: Text(profile.email),
                    trailing: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = !_isEditing;
                          _emailController.text = profile.email;
                        });
                      },
                      child: const Text("Cambiar Dirección de Correo Electrónico"),
                    ),
                  ),
                  if (_isEditing)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: "Nuevo Correo Electrónico",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ProfileBloc>().add(UpdateProfile(
                                profile.copyWith(email: _emailController.text),
                              ));
                              setState(() {
                                _isEditing = false;
                              });
                            },
                            child: const Text("Guardar"),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            } else if (state is ProfileError) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return const Center(child: Text("No se encontraron datos"));
          },
        ),
        bottomNavigationBar: const NavBar(),
      ),
    );
  }
}