import 'package:roademics/data/roadmaps/remote/roadmap_dto.dart';
import 'package:roademics/domain/ai_interaction/entities/ai_interaction.dart';

class AiDto {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<NodeDto>? nodes;
  final List<EdgeDto>? edges;

  AiDto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.nodes,
    required this.edges,
  });

  factory AiDto.fromJson(Map<String, dynamic> json) {
    return AiDto(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      nodes: json['nodes']
              .map<NodeDto>((node) => NodeDto.fromJson(node))
              .toList() ??
          [],
      edges: json['edges']
              .map<EdgeDto>((edge) => EdgeDto.fromJson(edge))
              .toList() ??
          [],
    );
  }

  AIInteraction toAIInteraction() {
    return AIInteraction(
      id: id,
      nodes: nodes?.map((node) => node.toNode()).toList() ?? [],
      edges: edges?.map((edge) => edge.toEdge()).toList() ?? [],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
