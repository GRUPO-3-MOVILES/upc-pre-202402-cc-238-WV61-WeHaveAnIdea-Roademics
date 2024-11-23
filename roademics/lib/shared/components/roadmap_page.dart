import 'package:flutter/material.dart';
import 'package:roademics/shared/components/home_page.dart';
import 'package:roademics/presentation/profiles/pages/profile_page.dart';
import 'package:roademics/shared/components/notification_page.dart';

class Roadmap extends StatefulWidget {
  const Roadmap({super.key});

  @override
  _RoadmapState createState() => _RoadmapState();
}

class _RoadmapState extends State<Roadmap> {
  List<String> roadmapSteps = ["Start"];

  void _addStep() {
    setState(() {
      roadmapSteps.add("New Step ${roadmapSteps.length + 1}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Roadmaps"),
        backgroundColor: const Color(0xFFF0FFFF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(roadmapSteps.length, (index) {
              return Column(
                children: [
                  Card(
                    elevation: 4,
                    color: index == 0
                        ? const Color(0xFFBCE6E6)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            roadmapSteps[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _editStep(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index != roadmapSteps.length - 1)
                    Container(
                      height: 40,
                      width: 2,
                      color: Colors.black,
                    ),
                ],
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStep,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
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

  Widget _buildBottomNavIcon(String label, String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            assetPath,
            height: 25,
          ),
          Text(label, style: const TextStyle(fontSize: 8, color: Colors.black)),
        ],
      ),
    );
  }

  void _editStep(int index) {
    TextEditingController controller = TextEditingController(text: roadmapSteps[index]);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Step'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter step name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  roadmapSteps[index] = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
