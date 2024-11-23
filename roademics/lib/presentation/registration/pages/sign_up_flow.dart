import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/data/profile/remote/profile_request.dart';
import 'package:roademics/data/registration/remote/regis_request.dart';
import 'package:roademics/presentation/authentication/bloc/login_bloc.dart';
import 'package:roademics/presentation/authentication/bloc/login_event.dart';
import 'package:roademics/presentation/authentication/bloc/login_state.dart';
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
    final loginBloc = context.read<LoginBloc>();

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
      dateOfBirth: DateTime.parse(_dateOfBirth.toString()),
      biography: _biographyController.text,
      profileType: _selectedProfileType!,
    );

    developer.log(
        "SignUpFlowPage: Registering user: ${registrationRequest.username}");

    signupBloc.add(SignupSubmitted(
      username: registrationRequest.username,
      password: registrationRequest.password,
    ));

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

        profileBloc.stream.listen((profileState) {
          if (profileState is ProfileSuccess) {
            developer.log(
                "SignUpFlowPage: Profile created successfully for user: ${signupState.user.username}");

            // Perform login after successful profile creation
            loginBloc.add(LoginSubmitted(
              username: registrationRequest.username,
              password: registrationRequest.password,
            ));

            loginBloc.stream.listen((loginState) {
              if (loginState is LoginSuccess) {
                developer.log(
                    "SignUpFlowPage: User logged in successfully: ${loginState.user.username} with this token: ${loginState.user.token}");

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              } else if (loginState is LoginError) {
                developer
                    .log("SignUpFlowPage: Login failed: ${loginState.message}");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(loginState.message)),
                );
              }
            });
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
      } else if (signupState is SignupError) {
        developer.log(
            "SignUpFlowPage: User registration failed: ${signupState.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(signupState.message)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignupBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Roademics"),
          centerTitle: true,
        ),
        body: SafeArea(
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
                      child: const Text('Anterior'),
                    ),
                  if (_currentPage < 4)
                    TextButton(
                      onPressed: _nextPage,
                      child: const Text('Siguiente'),
                    ),
                  if (_currentPage == 4)
                    ElevatedButton(
                      onPressed: _completeSignUp,
                      child: const Text('Completar Registro'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountInfoPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Información de Cuenta",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                  labelText: 'Username', prefixIcon: Icon(Icons.person_add))),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            obscureText: _isPasswordHidden,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              labelText: 'Contraseña',
              errorText: _passwordError,
              suffixIcon: IconButton(
                icon: Icon(_isPasswordHidden
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isPasswordHidden = !_isPasswordHidden;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _confirmPasswordController,
            obscureText: _isConfirmPasswordHidden,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              labelText: 'Confirmación de Contraseña',
              errorText: _passwordError,
              suffixIcon: IconButton(
                icon: Icon(_isConfirmPasswordHidden
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTypePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Selecciona tu tipo de perfil",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('EMPLOYER'),
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
            title: const Text('PATHFINDER'),
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
    );
  }

  Widget _buildLocationInfoPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Información de Ubicación",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: _cityController,
            decoration: const InputDecoration(
                labelText: 'Ciudad', prefixIcon: Icon(Icons.location_city)),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _stateController,
            decoration: const InputDecoration(
                labelText: 'Provincia/Estado',
                prefixIcon: Icon(Icons.location_city_outlined)),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _countryController,
            decoration: const InputDecoration(
                labelText: 'País',
                prefixIcon: Icon(Icons.location_city_rounded)),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _zipCodeController,
            decoration: const InputDecoration(
                labelText: 'Código Postal',
                prefixIcon: Icon(Icons.location_city_sharp)),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Información de Contacto",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(
                labelText: 'Nombre', prefixIcon: Icon(Icons.person)),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(
                labelText: 'Apellido', prefixIcon: Icon(Icons.person)),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneNumberController,
            decoration: const InputDecoration(
                labelText: 'Teléfono', prefixIcon: Icon(Icons.phone)),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
                labelText: 'E-mail', prefixIcon: Icon(Icons.email)),
          ),
        ],
      ),
    );
  }

  Widget _buildBiographyPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Perfil",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text("Cuéntanos un poco sobre ti para tu perfil."),
          const SizedBox(height: 8),
          TextField(
            controller: _biographyController,
            decoration: const InputDecoration(
              labelText: 'Biografía',
              hintText: 'Ej: Me gusta la tecnología y la educación...',
              prefixIcon: Icon(Icons.coffee),
            ),
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
