import 'package:flutter/material.dart';
//import 'package:roademics/shared/components/home_page.dart';
import 'package:roademics/shared/components/opportunities_page.dart';
//import 'package:roademics/shared/components/login.dart';
//import 'package:proyecto_0/src/features/profiles/presentation/pages/edit_profile_page.dart';
//import 'package:proyecto_0/src/features/profiles/presentation/pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF0FFFF),
        body: Center(
          child: OpportunitiesPage(),
        ),
      ),
      //home: Home(), // Invoca HomePage aquí.
    );
  }
}
