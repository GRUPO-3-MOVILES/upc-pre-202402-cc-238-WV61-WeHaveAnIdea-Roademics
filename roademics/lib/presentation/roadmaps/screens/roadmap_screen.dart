import 'package:flutter/material.dart';
import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:roademics/domain/roadmaps/entities/node_entity.dart'; 
import 'package:roademics/domain/roadmaps/entities/edge_entity.dart';
import 'package:roademics/domain/roadmaps/repositories/roadmaps_repository.dart';
import 'package:roademics/presentation/roadmaps/widgets/node_widget.dart';
import 'package:roademics/presentation/roadmaps/widgets/edge_widget.dart';

class RoadmapScreen extends StatefulWidget {
  final RoadmapRepository roadmapRepository;

  const RoadmapScreen({super.key, required this.roadmapRepository});

  @override
  _RoadmapScreenState createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  Roadmap? roadmap;

  @override
  void initState() {
    super.initState();
    _loadRoadmap();
  }

  Future<void> _loadRoadmap() async {
    try {
      final loadedRoadmap = await widget.roadmapRepository.fetchRoadmap("1");
      setState(() {
        roadmap = loadedRoadmap;
      });
    } catch (e) {
      print("Error al cargar el roadmap: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roadmap'),
      ),
      body: roadmap == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Text(
                  roadmap!.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(roadmap!.description),
                const Divider(),
                const Text('Nodes:', style: TextStyle(fontSize: 20)),
                ...roadmap!.nodes.map((node) => NodeWidget(node: node)),
                const Divider(),
                const Text('Edges:', style: TextStyle(fontSize: 20)),
                ...roadmap!.edges.map((edge) => EdgeWidget(edge: edge)),
              ],
            ),
    );
  }
}
