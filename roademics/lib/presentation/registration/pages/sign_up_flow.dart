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
        // Fondo global
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 3, 37, 37),
              Color.fromARGB(255, 7, 32, 78),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
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
                ],
              ),
              // Botón "Retroceder"
              if (_currentPage > 0)
                Positioned(
                  bottom: 50, // Ajustar para mover verticalmente
                  left: 16, // Ajustar para mover horizontalmente
                  child: IconButton(
                    onPressed: _previousPage,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 32,
                    ),
                    tooltip: 'Retroceder',
                  ),
                ),
              // Botón "Avanzar"
              if (_currentPage < 4)
                Positioned(
                  bottom: 50, // Ajustar para mover verticalmente
                  right: 16, // Ajustar para mover horizontalmente
                  child: IconButton(
                    onPressed: _nextPage,
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 32,
                    ),
                    tooltip: 'Avanzar',
                  ),
                ),
            ],
          ),
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
        const Text(
          "Información de Cuenta",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600, // Aumentado el grosor del texto
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'Username',
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500, // Grosor ajustado
              color: Colors.white,
            ),
            prefixIcon: Icon(Icons.person_add, color: Colors.white),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal, // Claridad ajustada para el input
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: _isPasswordHidden,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            prefixIcon: const Icon(Icons.lock, color: Colors.white),
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
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _confirmPasswordController,
          obscureText: _isConfirmPasswordHidden,
          decoration: InputDecoration(
            labelText: 'Confirmación de Contraseña',
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            prefixIcon: const Icon(Icons.lock, color: Colors.white),
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
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
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
            labelText: 'Nombre',
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.person, color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: 'Apellido',
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.person, color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _phoneNumberController,
          decoration: const InputDecoration(
            labelText: 'Teléfono',
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.phone, color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'E-mail',
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.email, color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
          style: const TextStyle(color: Colors.white),
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
            fillColor: MaterialStateProperty.all(Colors.white),
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
            fillColor: MaterialStateProperty.all(Colors.white),
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
            labelText: 'Ciudad',
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.location_city, color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _stateController,
          decoration: const InputDecoration(
            labelText: 'Provincia/Estado',
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.location_city_outlined, color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _countryController,
          decoration: const InputDecoration(
            labelText: 'País',
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.location_city_rounded, color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _zipCodeController,
          decoration: const InputDecoration(
            labelText: 'Código Postal',
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.location_city_sharp, color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}

Widget _buildBiographyPage() {
  bool _termsAccepted = false;

  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Perfil",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Cuéntanos un poco sobre ti para tu perfil.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.coffee,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _biographyController,
                    decoration: const InputDecoration(
                      hintText: 'Ej: Me gusta la tecnología y la educación...',
                      hintStyle: TextStyle(color: Colors.white70, fontSize: 16),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    maxLines: 5,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Sección de términos y condiciones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _termsAccepted,
                  activeColor: Colors.teal,
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      _termsAccepted = value!;
                    });
                  },
                ),
                const Text(
                  'He leído y acepto los términos y condiciones',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Mostrar el botón solo si se aceptaron los términos
            if (_termsAccepted)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Color del botón
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 32.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: _completeSignUp,
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Completar Registro',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    },
  );
}
}