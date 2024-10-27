import 'package:roademics/domain/roadmaps/entities/node_entity.dart';
import 'package:roademics/domain/roadmaps/entities/edge_entity.dart';

class Roadmap {
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final String? aiInteractionId;
  final bool? completed;
  final List<Node> nodes; // Usa Node en lugar de NodeModel
  final List<Edge> edges; // Usa Edge en lugar de EdgeModel

  Roadmap({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    this.completed,
    this.aiInteractionId,
    required this.nodes,
    required this.edges,
  });
}
