import 'package:flutter/material.dart';

class Recovery extends StatefulWidget {
  const Recovery({super.key});

  @override
  State<Recovery> createState() => _RecoveryState();
}

class _RecoveryState extends State<Recovery> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0FFFF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0C3350)), 
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        title: const Text("", style: TextStyle(color: Color(0xFF0C3350))), 
      ),
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
            const Text(
              "Recover Password",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF0C3350),
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //lógica para recuperar la contraseña
                String email = _emailController.text;
                
                print("Recuperar contraseña para: $email");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5F9EA0),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                "Recovery",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
