import 'package:flutter/material.dart';
import 'package:roademics/presentation/profiles/pages/profile_page.dart';
import 'package:roademics/shared/components/home_page.dart';
import 'package:roademics/shared/components/notification_page.dart';
import 'package:roademics/shared/components/roadmap_page.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFFF0FFFF),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(
              context,
              iconPath: 'assets/img/home.png',
              label: 'Home',
              targetPage: const Home(),
            ),
            _buildBottomNavItem(
              context,
              iconPath: 'assets/img/profile.png',
              label: 'Profile',
              targetPage: const ProfilePage(),
            ),
            _buildBottomNavItem(
              context,
              iconPath: 'assets/img/roadmaps.png',
              label: 'Roadmaps',
              targetPage: const Roadmap(),
            ),
            _buildBottomNavItem(
              context,
              iconPath: 'assets/img/notifications.png',
              label: 'Notifications',
              targetPage: const NotificationPage(),
            ),
            _buildBottomNavItem(
              context,
              iconPath: 'assets/img/opportunities.png',
              label: 'Opportunities',
              targetPage: null, 
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(BuildContext context, {required String iconPath, required String label, Widget? targetPage}) {
    return GestureDetector(
      onTap: () {
        if (targetPage != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            height: 25,
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 8, color: Colors.black),
          ),
        ],
      ),
    );
  }
}