import 'package:flutter/material.dart';
import 'package:roademics/presentation/profiles/pages/profile_page.dart';
import 'package:roademics/shared/components/home_page.dart';
import 'package:roademics/shared/components/notification_page.dart';
import 'package:roademics/shared/components/roadmap_page.dart';

class OpportunitiesPage extends StatelessWidget {
  const OpportunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opportunities'),
        backgroundColor: const Color(0xFFF0FFFF),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          _buildJobOffer(
            'Desarrollador de Software',
            'Google',
            'Mountain View, CA',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
            'Hace 2 horas',
          ),
          _buildJobOffer(
            'Ingeniero de Datos',
            'Facebook',
            'Menlo Park, CA',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/1024px-2021_Facebook_icon.svg.png',
            'Hace 3 horas',
          ),
          _buildJobOffer(
            'Gerente de Producto',
            'Amazon',
            'Seattle, WA',
            'https://w7.pngwing.com/pngs/444/310/png-transparent-amazon-com-amazon-prime-music-streaming-media-prime-now-payment-miscellaneous-text-logo-thumbnail.png',
            'Hace 5 horas',
          ),
          _buildJobOffer(
            'Diseñador UX/UI',
            'Apple',
            'Cupertino, CA',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAN6D3MaoWFSqboGZpHXxBZnqY4siyBKCX8g&s',
            'Hace 1 día',
          ),
          _buildJobOffer(
            'Analista de Negocios',
            'Microsoft',
            'Redmond, WA',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Microsoft_logo.svg/2048px-Microsoft_logo.svg.png',
            'Hace 6 horas',
          ),
          _buildJobOffer(
            'Desarrollador Frontend',
            'Netflix',
            'Los Gatos, CA',
            'https://i.pinimg.com/736x/9e/a0/1d/9ea01d1a050f773d5f43c0d9362def36.jpg',
            'Hace 8 horas',
          ),
          _buildJobOffer(
            'Ingeniero de DevOps',
            'Spotify',
            'Estocolmo, Suecia',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Spotify_logo_without_text.svg/1200px-Spotify_logo_without_text.svg.png',
            'Hace 1 día',
          ),
          _buildJobOffer(
            'Científico de Datos',
            'Twitter',
            'San Francisco, CA',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/X_logo.jpg/1024px-X_logo.jpg',
            'Hace 2 días',
          ),
          _buildJobOffer(
            'Administrador de Sistemas',
            'LinkedIn',
            'Sunnyvale, CA',
            'https://static.vecteezy.com/system/resources/previews/018/910/721/non_2x/linkedin-logo-linkedin-symbol-linkedin-icon-free-free-vector.jpg',
            'Hace 3 días',
          ),
          _buildJobOffer(
            'Ingeniero de Seguridad',
            'Tesla',
            'Palo Alto, CA',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Tesla_logo.png/1024px-Tesla_logo.png',
            'Hace 4 días',
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
                    const Text('Home', style: TextStyle(fontSize: 8, color: Colors.black)),
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
                    const Text('Profile', style: TextStyle(fontSize: 8, color: Colors.black)),
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
                    const Text('Roadmaps', style: TextStyle(fontSize: 8, color: Colors.black)),
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
                    const Text('Notifications', style: TextStyle(fontSize: 8, color: Colors.black)),
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
                    const Text('Opportunities', style: TextStyle(fontSize: 8, color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobOffer(String title, String company, String location, String logoUrl, String time) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(logoUrl),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(company),
            Text(location),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}