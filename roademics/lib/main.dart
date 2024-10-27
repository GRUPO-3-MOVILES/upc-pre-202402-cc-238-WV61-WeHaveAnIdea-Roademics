import 'package:flutter/material.dart';
import 'package:roademics/data/roadmaps/repository/roadmap_repository_impl.dart';
import 'package:roademics/presentation/roadmaps/screens/roadmap_screen.dart';


void main() {
    final roadmapRepository = RoadmapRepositoryImpl();

  runApp(MyApp(roadmapRepository: roadmapRepository));
}

class MyApp extends StatelessWidget {
  final RoadmapRepositoryImpl roadmapRepository;

  const MyApp({super.key, required this.roadmapRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roadmap App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RoadmapScreen(roadmapRepository: roadmapRepository),
    );
  }
}
