import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:roademics/presentation/profiles/bloc/profile_bloc.dart';
import 'package:roademics/presentation/profiles/bloc/profile_event.dart';
import 'package:roademics/presentation/profiles/bloc/profile_state.dart';
import 'package:roademics/presentation/profiles/widgets/nav_bar.dart';

class PhoneNumbersPage extends StatefulWidget {
  const PhoneNumbersPage({super.key});

  @override
  PhoneNumbersPageState createState() => PhoneNumbersPageState();
}

class PhoneNumbersPageState extends State<PhoneNumbersPage> {
  late ProfileBloc _profileBloc;
  String phoneNumber = "";
  bool isEditing = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  String initialCountry = 'PE'; 
  PhoneNumber number = PhoneNumber(isoCode: 'PE'); 

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Números de Teléfono"),
        backgroundColor: const Color(0xFFF0FFFF),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial || state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            phoneNumber = state.profile.personalInformation.phoneNumber;
            _phoneNumberController.text = phoneNumber;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Número de Teléfono Actual: $phoneNumber"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5F9EA0),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(isEditing ? 'Guardar Número de Teléfono' : 'Cambiar Número de Teléfono'),
                  ),
                  if (isEditing) ...[
                    const SizedBox(height: 20),
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        setState(() {
                          phoneNumber = number.phoneNumber!;
                        });
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: _phoneNumberController,
                      formatInput: false,
                      inputDecoration: const InputDecoration(
                        labelText: 'Nuevo Número de Teléfono',
                      ),
                      inputBorder: const OutlineInputBorder(),
                      onSaved: (PhoneNumber number) {
                        setState(() {
                          phoneNumber = number.phoneNumber!;
                        });
                      },
                    ),
                  ],
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text("Error: ${state.error}"));
          }
          return const Center(child: Text("No se encontraron datos"));
        },
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }
}