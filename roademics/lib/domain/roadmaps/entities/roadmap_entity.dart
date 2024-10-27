import 'package:roademics/data/roadmaps/remote/roadmaps_model.dart';

class Roadmap {
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final String? aiInteractionId;
  final bool completed;
  final List<Node> nodes;
  final List<Edge> edges;

  Roadmap({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    this.aiInteractionId,
    required this.completed,
    required this.nodes,
    required this.edges,
  });

  factory Roadmap.fromJson(Map<String, dynamic> json) {
    return Roadmap(
      id: json['id'],
      ownerId: json['ownerId'],
      title: json['title'],
      description: json['description'],
      aiInteractionId: json['aiInteractionId'],
      completed: json['completed'],
      nodes:
          (json['nodes'] as List).map((node) => Node.fromJson(node)).toList(),
      edges:
          (json['edges'] as List).map((edge) => Edge.fromJson(edge)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'ownerId': ownerId,
        'title': title,
        'description': description,
        'aiInteractionId': aiInteractionId,
        'completed': completed,
        'nodes': nodes.map((node) => node.toJson()).toList(),
        'edges': edges.map((edge) => edge.toJson()).toList(),
      };
}
