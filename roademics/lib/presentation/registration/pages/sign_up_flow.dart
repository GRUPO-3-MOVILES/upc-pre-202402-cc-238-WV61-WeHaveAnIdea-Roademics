import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/presentation/profile/bloc/profile_bloc.dart';
import 'package:roademics/presentation/profile/bloc/profile_event.dart';
import 'package:roademics/presentation/registration/bloc/signup_bloc.dart';
import 'package:roademics/presentation/registration/bloc/signup_event.dart';
import 'package:roademics/presentation/registration/bloc/signup_state.dart';
import 'package:roademics/presentation/authentication/bloc/login_bloc.dart';
import 'package:roademics/shared/presentation/widgets/loading_widget.dart';

class SignUpFlowPage extends StatefulWidget {
  const SignUpFlowPage({Key? key}) : super(key: key);

  @override
  State<SignUpFlowPage> createState() => _SignUpFlowPageState();
}

class _SignUpFlowPageState extends State<SignUpFlowPage> {
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _dateOfBirth = DateTime.now();
  int _currentPage = 0;
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
      if (_formKey.currentState?.validate() ?? false) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPage++;
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
    if (_formKey.currentState?.validate() ?? false) {
      context.read<SignupBloc>().add(
            SignupSubmitted(
              username: _usernameController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignupBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(create: (_) => LoginBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Roademics"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocConsumer<SignupBloc, SignupState>(
            listener: (context, signupState) {
              if (signupState is SignupSuccess) {
                context.read<ProfileBloc>().add(
                      CreateProfile(
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
                      ),
                    );
              } else if (signupState is SignupError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(signupState.message)),
                );
              }
            },
            builder: (context, signupState) {
              if (signupState is SignupLoading) {
                return const LoadingWidget();
              }

              return Form(
                key: _formKey,
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
              );
            },
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El nombre de usuario es obligatorio';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
              labelText: 'Confirmar Contraseña',
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
            validator: (value) {
              if (value != _passwordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
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
          TextFormField(
            controller: _firstNameController,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El nombre es obligatorio';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              labelText: 'Apellido',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
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
