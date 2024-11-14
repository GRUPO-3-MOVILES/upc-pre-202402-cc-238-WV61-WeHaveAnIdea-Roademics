import 'package:flutter/material.dart';
import 'package:roademics/shared/presentation/pages/home_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Invoca HomePage aquí
    );
  }
}
