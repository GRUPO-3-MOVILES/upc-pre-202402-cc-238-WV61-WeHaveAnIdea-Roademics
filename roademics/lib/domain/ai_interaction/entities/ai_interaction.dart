import 'package:roademics/domain/roadmaps/entities/edge_entity.dart';
import 'package:roademics/domain/roadmaps/entities/node_entity.dart';

class AIInteraction {
  final String id;
  final String? prompt;
  final List<Node> nodes;
  final List<Edge> edges;
  final DateTime createdAt;
  final DateTime updatedAt;

  AIInteraction(
      {required this.id,
      this.prompt,
      required this.nodes,
      required this.edges,
      required this.createdAt,
      required this.updatedAt});
}
