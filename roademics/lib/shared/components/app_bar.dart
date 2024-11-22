// custom_bottom_app_bar.dart
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomAppBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home, "Inicio", 0),
          _buildNavItem(Icons.business_center, "Oportunidades", 1),
          _buildNavItem(Icons.account_tree, "Roadmaps", 2),
          _buildNavItem(Icons.notifications, "Notificaciones", 3),
          _buildNavItem(Icons.person, "Perfil", 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: selectedIndex == index ? Colors.black : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: selectedIndex == index ? Colors.black : Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
