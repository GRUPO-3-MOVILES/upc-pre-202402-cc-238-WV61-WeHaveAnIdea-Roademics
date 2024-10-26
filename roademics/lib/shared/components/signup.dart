import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  String _accountType = 'Select Account Type';
  bool _acceptedTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" "),backgroundColor: const Color(0xFFF0FFFF)),
      backgroundColor: const Color(0xFFF0FFFF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Roademics",
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C3350),
                fontFamily: 'Raleway',
              ),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFBCE6E6),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      hintText: "Full Name",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5F9EA0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5F9EA0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5F9EA0)),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),

                  TextField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      hintText: "Password Confirmation",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5F9EA0)),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),

                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      hintText: "Phone Number",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5F9EA0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  DropdownButtonFormField<String>(
                    value: _accountType,
                    items: <String>['Select Account Type', 'Personal', 'Enterprise']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _accountType = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      hintText: "Account Type",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5F9EA0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _acceptedTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _acceptedTerms = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text("I accept the terms and conditions", style: TextStyle(
                      color: Color(0xFFB1B1B1),
                    )),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20.0),

            const ElevatedButtonExample(), 
          ],
        ),
      ),
    );
  }
}

class ElevatedButtonExample extends StatefulWidget {
  const ElevatedButtonExample({super.key});

  @override
  State<ElevatedButtonExample> createState() => _ElevatedButtonExampleState();
}

class _ElevatedButtonExampleState extends State<ElevatedButtonExample> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF5F9EA0),
    );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: style,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Registration button pressed")),
              );
            },
            child: const Text('SIGN UP'),
          ),
        ],
      ),
    );
  }
}
