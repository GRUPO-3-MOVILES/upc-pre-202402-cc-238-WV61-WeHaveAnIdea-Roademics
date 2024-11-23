import 'package:roademics/domain/roadmaps/entities/edge_entity.dart';
import 'package:roademics/domain/roadmaps/entities/node_entity.dart';
import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';

class RoadmapDto {
  String id;
  String ownerId;
  String title;
  String description;
  String aiInteractionId;
  List<NodeDto>? nodes;
  List<EdgeDto>? edges;

  RoadmapDto({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.aiInteractionId,
    this.nodes,
    this.edges,
  });

  factory RoadmapDto.fromJson(Map<String, dynamic> json) {
    return RoadmapDto(
      id: json['id'] ?? '',
      ownerId: json['ownerId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      aiInteractionId: json['aiInteractionId'] ?? '',
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

  Roadmap toRoadmap() {
    return Roadmap(
      id: id,
      ownerId: ownerId,
      title: title,
      description: description,
      aiInteractionId: aiInteractionId,
      nodes: nodes?.map((node) => node.toNode()).toList() ?? [],
      edges: edges?.map((edge) => edge.toEdge()).toList() ?? [],
    );
  }
}

class NodeDto {
  String nodeId;
  String title;
  String description;
  bool isStartNode;
  bool isEndNode;

  NodeDto({
    required this.nodeId,
    required this.title,
    required this.description,
    required this.isStartNode,
    required this.isEndNode,
  });

  factory NodeDto.fromJson(Map<String, dynamic> json) {
    return NodeDto(
      nodeId: json['nodeId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isStartNode: json['isStartNode'] ?? false,
      isEndNode: json['isEndNode'] ?? false,
    );
  }

  Node toNode() {
    return Node(
      nodeId: nodeId,
      title: title,
      description: description,
      isStartNode: isStartNode,
      isEndNode: isEndNode,
    );
  }
}

class EdgeDto {
  String fromNodeId;
  String toNodeId;
  String label;
  String description;
  String relationshipType;

  EdgeDto({
    required this.fromNodeId,
    required this.toNodeId,
    required this.label,
    required this.description,
    required this.relationshipType,
  });

  factory EdgeDto.fromJson(Map<String, dynamic> json) {
    return EdgeDto(
      fromNodeId: json['fromNodeId'],
      toNodeId: json['toNodeId'],
      label: json['label'],
      description: json['description'],
      relationshipType: json['relationshipType'],
    );
  }

  Edge toEdge() {
    return Edge(
      fromNodeId: fromNodeId,
      toNodeId: toNodeId,
      label: label,
      description: description,
      relationshipType: relationshipType,
    );
  }
}
