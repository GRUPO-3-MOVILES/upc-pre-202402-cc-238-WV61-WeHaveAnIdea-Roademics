import 'package:flutter/material.dart';
import 'package:roademics/presentation/profiles/pages/profile_page.dart';
import 'package:roademics/shared/components/home_page.dart';
import 'package:roademics/shared/components/opportunities_page.dart';
import 'package:roademics/shared/components/roadmap_page.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFFF0FFFF),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          _buildNotificationItem(
            'Ana Gómez',
            'te ha enviado un mensaje directo.',
            'https://i.pinimg.com/originals/eb/63/6a/eb636a30acae0689c3fa53353975aed6.jpg',
            'Hace 10 minutos',
          ),
          _buildNotificationItem(
            'Luis Rodríguez',
            'ha compartido tu publicación.',
            'https://i.pinimg.com/236x/b1/9a/17/b19a17f28f4e0b7641ef62d8690f7dd5.jpg',
            'Hace 1 hora',
          ),
          _buildNotificationItem(
            'Sofía Martínez',
            'te ha seguido.',
            'https://st3.depositphotos.com/1662991/33647/i/450/depositphotos_336475472-stock-photo-portrait-happy-good-looking-female.jpg',
            'Hace 2 horas',
          ),
          _buildNotificationItem(
            'Roademics',
            'Te sugerimos seguir a José Herrera.',
            'https://example.com/profile8.png',
            'Hace 3 horas',
          ),
          _buildNotificationItem(
            'Pedro Sánchez',
            'ha reaccionado a tu historia.',
            'https://img.freepik.com/fotos-premium/feliz-orgulloso-prospero-mediana-edad-maduro-profesional-hombre-negocios-ceo-ejecutivo-vistiendo-traje-posicion-oficina-brazos-cruzados-mirar-lejos-pensamiento-exito-liderazgo-lado-perfil-vista_868783-17934.jpg',
            'Hace 4 horas',
          ),
          _buildNotificationItem(
            'Laura Fernández',
            'te ha etiquetado en una publicación.',
            'https://i.pinimg.com/236x/b3/22/d5/b322d596cd1493ac7c4166cfeaec4ede.jpg',
            'Hace 6 horas',
          ),
          _buildNotificationItem(
            'José Pérez',
            'ha respondido a tu comentario.',
            'https://www.orlandopalma.com/wp-content/gallery/hombres/fotografia-retrato-hombre-ejecutivo-socio-ceo-elegante-corporativo-san-isidro-lima-peru-9.jpg',
            'Hace 8 horas',
          ),
          _buildNotificationItem(
            'Instagram',
            'Te sugerimos seguir a Marta López.',
            'https://example.com/profile12.png',
            'Hace 1 día',
          ),
          _buildNotificationItem(
            'Iván Gómez',
            'te ha enviado una solicitud de amistad.',
            'https://www.orlandopalma.com/wp-content/gallery/hombres/fotografia-retrato-hombre-ejecutivo-socio-ceo-elegante-corporativo-san-isidro-lima-peru-1.jpg',
            'Hace 2 días',
          ),
          _buildNotificationItem(
            'Elena Díaz',
            'ha comentado en tu foto.',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZgZUBz8fnAaj1xHNFQNKOqLoQjgLL6u5HSw&s',
            'Hace 3 días',
          ),
          _buildNotificationItem(
            'Carlos Herrera',
            'ha compartido tu historia.',
            'https://i.pinimg.com/236x/a0/f3/3c/a0f33c0137ebd5d2780d1496a0a0e490.jpg',
            'Hace 4 días',
          ),
          _buildNotificationItem(
            'LinkedIn',
            'Te sugerimos seguir a Beatriz Torres.',
            'https://example.com/profile16.png',
            'Hace 5 días',
          ),
          _buildNotificationItem(
            'Fernando Ruiz',
            'te ha enviado un correo.',
            'https://us.123rf.com/450wm/justmeyo/justmeyo1009/justmeyo100900183/7837210-sonriente-hombre-ejecutivo-de-pie-con-los-brazos-se-disolvi%C3%B3-en-semi-perfil-aislado-sobre-fondo.jpg',
            'Hace 6 días',
          ),
          _buildNotificationItem(
            'Marina García',
            'ha dado like a tu foto.',
            'https://i.pinimg.com/originals/ae/99/b9/ae99b90150ebe67487e5d839ecba285a.jpg',
            'Hace 7 días',
          ),
          _buildNotificationItem(
            'Facebook',
            'Te sugerimos seguir a Álvaro Pérez.',
            'https://example.com/profile19.png',
            'Hace 8 días',
          ),
          _buildNotificationItem(
            'Raúl Martínez',
            'te ha enviado una invitación para un evento.',
            'https://img.freepik.com/foto-gratis/vista-lateral-hombre-serio_23-2148946213.jpg',
            'Hace 9 días',
          ),
          _buildNotificationItem(
            'Sandra López',
            'ha dado like a tu publicación.',
            'https://www.protocolo.com.mx/wp-content/uploads/maria-cavalcanti.jpg',
            'Hace 10 días',
          ),
          _buildNotificationItem(
            'Gina Vargas',
            'ha reaccionado a tu video.',
            'https://i.pinimg.com/originals/94/f4/a4/94f4a4c9ff68e47c3295769e0578f18d.jpg',
            'Hace 11 días',
          ),
          _buildNotificationItem(
            'Oscar Romero',
            'te ha enviado un mensaje de voz.',
            'https://b2472105.smushcdn.com/2472105/wp-content/uploads/2023/12/Poses-Perfil-Profesional-Hombresoct.-17-2022-3-819x1024.jpg?lossy=1&strip=1&webp=1',
            'Hace 12 días',
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
                  // Acción al presionar Notificaciones
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OpportunitiesPage()),
                  );
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

  Widget _buildNotificationItem(String title, String subtitle, String imageUrl, String time) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
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