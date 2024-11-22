// home_page.dart
import 'package:flutter/material.dart';
import 'package:roademics/shared/components/app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Inicio Screen')),
    Center(child: Text('Perfil Screen')),
    Center(child: Text('Roadmap Screen')),
    Center(child: Text('Notificaciones Screen')),
    Center(child: Text('Oportunidades Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
