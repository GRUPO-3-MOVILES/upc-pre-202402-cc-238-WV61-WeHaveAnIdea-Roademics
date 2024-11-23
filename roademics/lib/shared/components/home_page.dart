import 'package:flutter/material.dart';
import 'dart:math';
import 'package:roademics/presentation/profiles/pages/profile_page.dart';
import 'package:roademics/shared/components/roadmap_page.dart';
import 'package:roademics/shared/components/notification_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLiked = false;
  int _reactionCount = 0;

  @override
  void initState() {
    super.initState();
    _reactionCount = Random().nextInt(200);
  }
  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _reactionCount += _isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
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
                        backgroundImage: NetworkImage('https://b2472105.smushcdn.com/2472105/wp-content/uploads/2023/12/Poses-Perfil-Profesional-Hombresdic.-27-2022-3-819x1024.jpg?lossy=1&strip=1&webp=1'),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Carlos Ramirez",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          Text(
                            "Desarrollador de Software",
                            style: TextStyle(
                              color: Colors.grey,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            "2 months ago",
                            style: TextStyle(
                              color: Colors.grey,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Aquí les comparto mi roadmap actualizado para julio 2024. Agradezco a todos por el apoyo constante que estoy recibiendo en este proceso a convertirme en desarrollador de software #Roadmap #Software",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Image.network('https://static-cse.canva.com/blob/1446816/08_gantt-chart-roadmap-whiteboard-in-neon-green-purple-friendly-professional-style.png'),
                  const SizedBox(height: 10),
                  Text(
                    "$_reactionCount reactions",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: _toggleLike,
                        child: Column(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: _isLiked ? Colors.blue : Colors.grey,
                            ),
                            const Text("Reactions"),
                          ],
                        ),
                      ),
                      const Column(
                        children: [
                          Icon(Icons.comment, color: Colors.grey),
                          Text("Comment"),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.share, color: Colors.grey),
                          Text("Share"),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.bookmark, color: Colors.grey),
                          Text("Save"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
                        backgroundImage: NetworkImage('https://b2472105.smushcdn.com/2472105/wp-content/uploads/2023/09/Poses-Perfil-Profesional-Mujeres-ago.-10-2023-1-819x1024.jpg?lossy=1&strip=1&webp=1'),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Linda Flores Rojas",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          Text(
                            "Marketing Digital y Diseño Gráfico",
                            style: TextStyle(
                              color: Colors.grey,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            "6 hours ago",
                            style: TextStyle(
                              color: Colors.grey,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "¡Hola a todos! Les comparto como va quedando mi roadmap para finales del 2024. Estoy emocionada por todo lo que se viene y agradezco a todos por el apoyo que me han brindado desde el inicio de mi vida profesional. #Roadmap #MarketingDigital #DiseñoGráfico",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Image.network('https://www.slideteam.net/media/catalog/product/cache/1280x720/c/a/career_timelines_roadmap_powerpoint_slide_for_e_commerce_mobile__Slide01.jpg'),
                  const SizedBox(height: 10),
                  Text(
                    "$_reactionCount reactions",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: _toggleLike,
                        child: Column(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: _isLiked ? Colors.blue : Colors.grey,
                            ),
                            const Text("Reactions"),
                          ],
                        ),
                      ),
                      const Column(
                        children: [
                          Icon(Icons.comment, color: Colors.grey),
                          Text("Comment"),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.share, color: Colors.grey),
                          Text("Share"),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.bookmark, color: Colors.grey),
                          Text("Save"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
                        backgroundImage: NetworkImage('https://b2472105.smushcdn.com/2472105/wp-content/uploads/2023/12/Poses-Perfil-Profesional-Hombres-jun.-26-2023-819x1024.jpg?lossy=1&strip=1&webp=1'),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Armando Rojas Paredes",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          Text(
                            "Desarrollador Backend",
                            style: TextStyle(
                              color: Colors.grey,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            "3 weeks ago",
                            style: TextStyle(
                              color: Colors.grey,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "¡Hola a todos! Les comparto mi roadmap en lo que va del año, este último mes fue de aprendizaje y crecimiento. Agradezco a mi jefe por darme el tiempo para poder capacitarme y a mi equipo por el apoyo constante. #Roadmap #DesarrolladorBackend",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Image.network('https://miro.medium.com/v2/resize:fit:1400/0*Bhxc6GXciql_8v8L.jpg'),
                  const SizedBox(height: 10),
                  Text(
                    "$_reactionCount reactions",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: _toggleLike,
                        child: Column(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: _isLiked ? Colors.blue : Colors.grey,
                            ),
                            const Text("Reactions"),
                          ],
                        ),
                      ),
                      const Column(
                        children: [
                          Icon(Icons.comment, color: Colors.grey),
                          Text("Comment"),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.share, color: Colors.grey),
                          Text("Share"),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.bookmark, color: Colors.grey),
                          Text("Save"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
                        backgroundImage: NetworkImage('https://b2472105.smushcdn.com/2472105/wp-content/uploads/2024/09/Poses-Perfil-Profesional-Hombres-dic.-14-2023-1-819x1024.jpg?lossy=1&strip=1&webp=1'),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pablo Ríos fuertes",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          Text(
                            "Administrador de Base de Datos",
                            style: TextStyle(
                              color: Colors.grey,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            "14 hours ago",
                            style: TextStyle(
                              color: Colors.grey,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "¡Hola a todos! Les comparto el roadmap que tengo pensado seguir para el próximo año 2025, estoy abierto a sugerencias y consejos. #Roadmap #AdministradorBaseDatos",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Image.network('https://todobi.com/content/images/2020/10/roadmap2.png'),
                  const SizedBox(height: 10),
                  Text(
                    "$_reactionCount reactions",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: _toggleLike,
                        child: Column(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: _isLiked ? Colors.blue : Colors.grey,
                            ),
                            const Text("Reactions"),
                          ],
                        ),
                      ),
                      const Column(
                        children: [
                          Icon(Icons.comment, color: Colors.grey),
                          Text("Comment"),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.share, color: Colors.grey),
                          Text("Share"),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.bookmark, color: Colors.grey),
                          Text("Save"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
                        backgroundImage: NetworkImage('https://b2472105.smushcdn.com/2472105/wp-content/uploads/2024/09/HeadShots-jul.-19-2024.jpg?lossy=1&strip=1&webp=1'),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Elena Casas Blancas",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          Text(
                            "Especialista en Seguridad de Redes",
                            style: TextStyle(
                              color: Colors.grey,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            "5 weeks ago",
                            style: TextStyle(
                              color: Colors.grey,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Este es el roadmap que seguí para mantenerme actualizada en seguridad de redes. Agradezco a todos por el apoyo y a mi equipo por la paciencia. #Roadmap #SeguridadRedes",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Image.network('https://i0.wp.com/achirou.com/wp-content/uploads/2024/07/ruta-2024-k.jpg?resize=1024%2C751&ssl=1'),
                  const SizedBox(height: 10),
                  Text(
                    "$_reactionCount reactions",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: _toggleLike,
                        child: Column(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: _isLiked ? Colors.blue : Colors.grey,
                            ),
                            const Text("Reactions"),
                          ],
                        ),
                      ),
                      const Column(
                        children: [
                          Icon(Icons.comment, color: Colors.grey),
                          Text("Comment"),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.share, color: Colors.grey),
                          Text("Share"),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.bookmark, color: Colors.grey),
                          Text("Save"),
                        ],
                      ),
                    ],
                  ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationPage()),
                  );
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
                  // Acción al presionar Opportunities
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



