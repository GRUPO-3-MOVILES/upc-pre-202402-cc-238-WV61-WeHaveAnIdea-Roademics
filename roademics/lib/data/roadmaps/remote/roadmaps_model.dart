import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:roademics/data/roadmaps/remote/node_model.dart';
import 'package:roademics/data/roadmaps/remote/edge_model.dart';

class RoadmapModel {
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final String? aiInteractionId;
  final bool isCompleted;
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;

  RoadmapModel({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    this.aiInteractionId,
    required this.isCompleted,
    required this.nodes,
    required this.edges,
  }) {
    assert(id.isNotEmpty, 'El id no puede estar vacío');
    assert(ownerId.isNotEmpty, 'El ownerId no puede estar vacío');
    assert(title.isNotEmpty, 'El título no puede estar vacío');
    assert(description.isNotEmpty, 'La descripción no puede estar vacía');
    assert(nodes.isNotEmpty, 'Debe haber al menos un nodo en el roadmap');
    assert(edges.length >= nodes.length - 1,
        'Debe haber suficientes edges para conectar los nodos');
  }
  // Constructor para crear un RoadmapModel a partir de un Roadmap
  factory RoadmapModel.fromEntity(Roadmap roadmap) {
    return RoadmapModel(
      id: roadmap.id,
      ownerId: roadmap.ownerId,
      title: roadmap.title,
      description: roadmap.description,
      aiInteractionId: roadmap.aiInteractionId,
      isCompleted: roadmap.completed ?? false,
      nodes: roadmap.nodes.map((node) => NodeModel(
        nodeId: node.nodeId,
        title: node.title,
        description: node.description,
        isStartNode: node.isStartNode,
        isEndNode: node.isEndNode,
      )).toList(),
      edges: roadmap.edges.map((edge) => EdgeModel(
        fromNodeId: edge.fromNodeId,
        toNodeId: edge.toNodeId,
        label: edge.label,
        description: edge.description,
        relationshipType: edge.relationshipType,
      )).toList(),
    );
  }

  factory RoadmapModel.fromJson(Map<String, dynamic> json) {
    return RoadmapModel(
      id: json['id'],
      ownerId: json['ownerId'],
      title: json['title'],
      description: json['description'],
      aiInteractionId: json['aiInteractionId'],
      isCompleted: json['isCompleted'],
      nodes: (json['nodes'] as List).map((node) => NodeModel.fromJson(node)).toList(),
      edges: (json['edges'] as List).map((edge) => EdgeModel.fromJson(edge)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'ownerId': ownerId,
        'title': title,
        'description': description,
        'aiInteractionId': aiInteractionId,
        'isCompleted': isCompleted,
        'nodes': nodes.map((node) => node.toJson()).toList(),
        'edges': edges.map((edge) => edge.toJson()).toList(),
      };
}
