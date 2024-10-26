import 'package:flutter/material.dart';
import 'package:roademics/shared/components/home_page.dart';
import 'signup.dart';
import 'recovery.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _RootpageState();
}

class _RootpageState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
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
                fontFamily: 'Raleway'
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                hintText: "Enter your user",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF5F9EA0))
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
                hintText: "Enter your password",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF5F9EA0))
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Recovery()), 
                );
              },
              child: const Text(
                "Recover password",
                style: TextStyle(
                  color: Color(0xFF5F9EA0),  
                  fontSize: 16,
                ),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
            child: const Text('LOG IN'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Signup()),
              );
            },
            child: const Text('SIGN UP'),
          ),
        ],
      ),
    );
  }
}
