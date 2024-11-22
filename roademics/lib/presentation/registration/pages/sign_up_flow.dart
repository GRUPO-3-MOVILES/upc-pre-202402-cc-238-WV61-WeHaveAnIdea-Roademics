import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/data/profile/remote/profile_request.dart';
import 'package:roademics/data/registration/remote/regis_request.dart';
import 'package:roademics/presentation/profile/bloc/profile_bloc.dart';
import 'package:roademics/presentation/profile/bloc/profile_event.dart';
import 'package:roademics/presentation/profile/bloc/profile_state.dart';
import 'package:roademics/presentation/registration/bloc/signup_bloc.dart';
import 'package:roademics/presentation/registration/bloc/signup_event.dart';
import 'package:roademics/presentation/registration/bloc/signup_state.dart';
import 'package:roademics/shared/presentation/pages/home_page.dart';
import 'dart:developer' as developer;

class SignUpFlowPage extends StatefulWidget {
  const SignUpFlowPage({Key? key}) : super(key: key);

  @override
  SignUpFlowPageState createState() => SignUpFlowPageState();
}

class SignUpFlowPageState extends State<SignUpFlowPage> {
  final PageController _pageController = PageController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();

  final DateTime _dateOfBirth = DateTime.now();
  int _currentPage = 0;
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  String? _passwordError;

  String? _selectedProfileType;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _zipCodeController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _biographyController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 4) {
      if (_currentPage == 0 &&
          _passwordController.text != _confirmPasswordController.text) {
        setState(() {
          _passwordError = 'Las contraseñas no coinciden';
        });
      } else if (_currentPage == 1 && _selectedProfileType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Debe seleccionar un tipo de perfil')),
        );
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPage++;
          _passwordError = null;
        });
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage--;
      });
    }
  }

  void _completeSignUp() {
    final signupBloc = context.read<SignupBloc>();
    final profileBloc = context.read<ProfileBloc>();

    final RegistrationRequest registrationRequest = RegistrationRequest(
      username: _usernameController.text,
      password: _passwordController.text,
    );

    final ProfileRequest profileRequest = ProfileRequest(
      city: _cityController.text,
      state: _stateController.text,
      country: _countryController.text,
      zipCode: _zipCodeController.text,
      phoneNumber: _phoneNumberController.text,
      email: _emailController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      dateOfBirth: _dateOfBirth,
      biography: _biographyController.text,
      profileType: _selectedProfileType!,
    );

    developer.log(
        "SignUpFlowPage: Registering user: ${registrationRequest.username}");

    signupBloc.stream.listen((signupState) async {
      if (signupState is SignupSuccess) {
        developer.log(
            "SignUpFlowPage: User registered successfully: ${signupState.user.username}");

        developer.log(
            "SignUpFlowPage: Starting profile creation for user: ${signupState.user.username}");
        profileBloc.add(CreateProfile(
          city: profileRequest.city,
          state: profileRequest.state,
          country: profileRequest.country,
          zipCode: profileRequest.zipCode,
          phoneNumber: profileRequest.phoneNumber,
          email: profileRequest.email,
          firstName: profileRequest.firstName,
          lastName: profileRequest.lastName,
          dateOfBirth: profileRequest.dateOfBirth,
          biography: profileRequest.biography,
          profileType: profileRequest.profileType,
        ));
      }

      if (signupState is SignupError) {
        developer.log(
            "SignUpFlowPage: User registration failed: ${signupState.message}");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(signupState.message)),
          );
        }
      }
    });

    profileBloc.stream.listen((profileState) {
      if (profileState is ProfileSuccess) {
        developer.log(
            "SignUpFlowPage: Profile created successfully: ${profileState.profile}");
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } else if (profileState is ProfileError) {
        developer.log(
            "SignUpFlowPage: Profile creation failed: ${profileState.message}");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(profileState.message)),
          );
        }
      }
    });

    signupBloc.add(SignupSubmitted(
      username: registrationRequest.username,
      password: registrationRequest.password,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignupBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
      ],
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0A3D62), Color(0xFF40E0D0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildAccountInfoPage(),
                      _buildProfileTypePage(),
                      _buildContactInfoPage(),
                      _buildLocationInfoPage(),
                      _buildBiographyPage(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage > 0)
                      TextButton(
                        onPressed: _previousPage,
                        child: const Text(
                          'Anterior',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    if (_currentPage < 4)
                      TextButton(
                        onPressed: _nextPage,
                        child: const Text(
                          'Siguiente',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    if (_currentPage == 4)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 9, 50, 75),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: _completeSignUp,
                        child: const Text(
                          'Completar Registro',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

    Widget _buildProfileTypePage() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Selecciona tu tipo de perfil",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text(
                'EMPLOYER',
                style: TextStyle(color: Colors.white),
              ),
              leading: Radio<String>(
                value: 'EMPLOYER',
                groupValue: _selectedProfileType,
                onChanged: (value) {
                  setState(() {
                    _selectedProfileType = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text(
                'PATHFINDER',
                style: TextStyle(color: Colors.white),
              ),
              leading: Radio<String>(
                value: 'PATHFINDER',
                groupValue: _selectedProfileType,
                onChanged: (value) {
                  setState(() {
                    _selectedProfileType = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoPage() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Información de Contacto",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.white),
                labelText: 'Nombre',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.white),
                labelText: 'Apellido',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone, color: Colors.white),
                labelText: 'Teléfono',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.white),
                labelText: 'E-mail',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInfoPage() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Información de Ubicación",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_city, color: Colors.white),
                labelText: 'Ciudad',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _stateController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on, color: Colors.white),
                labelText: 'Estado',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.flag, color: Colors.white),
                labelText: 'País',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBiographyPage() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Biografía",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _biographyController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description, color: Colors.white),
                labelText: 'Cuéntanos sobre ti',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountInfoPage() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Información de Cuenta",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.white),
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: _isPasswordHidden,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock, color: Colors.white),
                labelText: 'Contraseña',
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                errorText: _passwordError,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              obscureText: _isConfirmPasswordHidden,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock, color: Colors.white),
                labelText: 'Confirmar Contraseña',
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                    });
                  },
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
