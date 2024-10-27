import 'package:roademics/data/roadmaps/remote/roadmaps_model.dart';

class Roadmap {
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final List<Node> nodes;
  final List<Edge> edges;
  final bool isCompleted;

  Roadmap({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.nodes,
    required this.edges,
    required this.isCompleted,
  });
}
