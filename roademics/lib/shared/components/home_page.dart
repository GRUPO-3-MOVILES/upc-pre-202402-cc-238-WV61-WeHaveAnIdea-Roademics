import 'package:flutter/material.dart';
import 'package:roademics/presentation/profiles/pages/profile_page.dart';
import 'package:roademics/shared/components/roadmap_page.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Back"),
        backgroundColor: const Color(0xFFF0FFFF),
      ),


      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/img/profile.png'),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Carlos Ramirez",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "2 hours ago",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    "Aquí les comparto mi roadmap actualizado para julio 2024. Agradezco a todos por el apoyo en este camino #Roadmap #Software",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),

                  Image.asset('assets/img/home.png'),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFF0FFFF),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/img/home.png',
                      height: 25,
                    ),
                    const Text(
                      'Home',
                      style: TextStyle(fontSize: 8, color: Colors.black),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/img/profile.png',
                      height: 25,
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(fontSize: 8, color: Colors.black),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Roadmap()),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/img/roadmaps.png',
                      height: 25,
                    ),
                    const Text(
                      'Roadmaps',
                      style: TextStyle(fontSize: 8, color: Colors.black),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Acción al presionar Notificaciones
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/img/notifications.png',
                      height: 25,
                    ),
                    const Text(
                      'Notifications',
                      style: TextStyle(fontSize: 8, color: Colors.black),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Acción al presionar opportunities
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/img/opportunities.png',
                      height: 25,
                    ),
                    const Text(
                      'Opportunities',
                      style: TextStyle(fontSize: 8, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

