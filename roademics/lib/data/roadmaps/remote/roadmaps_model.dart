class RoadmapModel {
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final List<Node> nodes;
  final List<Edge> edges;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  RoadmapModel({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.nodes,
    required this.edges,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  // Método para crear una instancia de Roadmap desde un JSON
  factory RoadmapModel.fromJson(Map<String, dynamic> json) {
    return RoadmapModel(
      id: json['_id'],
      ownerId: json['ownerId'],
      title: json['title'],
      description: json['description'],
      nodes: List<Node>.from(json['nodes'].map((node) => Node.fromJson(node))),
      edges: List<Edge>.from(json['edges'].map((edge) => Edge.fromJson(edge))),
      isCompleted: json['isCompleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Método para convertir una instancia de Roadmap a JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'nodes': nodes.map((node) => node.toJson()).toList(),
      'edges': edges.map((edge) => edge.toJson()).toList(),
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Node {
  final String nodeId;
  final String title;
  final String description;
  final bool isStartNode;
  final bool isEndNode;

  Node({
    required this.nodeId,
    required this.title,
    required this.description,
    required this.isStartNode,
    required this.isEndNode,
  });

  // Método para crear una instancia de Node desde un JSON
  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      nodeId: json['nodeId'],
      title: json['title'],
      description: json['description'],
      isStartNode: json['isStartNode'],
      isEndNode: json['isEndNode'],
    );
  }

  // Método para convertir una instancia de Node a JSON
  Map<String, dynamic> toJson() {
    return {
      'nodeId': nodeId,
      'title': title,
      'description': description,
      'isStartNode': isStartNode,
      'isEndNode': isEndNode,
    };
  }
}

class Edge {
  final String fromNodeId;
  final String toNodeId;
  final String label;
  final String description;
  final String relationshipType;

  Edge({
    required this.fromNodeId,
    required this.toNodeId,
    required this.label,
    required this.description,
    required this.relationshipType,
  });

  // Método para crear una instancia de Edge desde un JSON
  factory Edge.fromJson(Map<String, dynamic> json) {
    return Edge(
      fromNodeId: json['fromNodeId'],
      toNodeId: json['toNodeId'],
      label: json['label'],
      description: json['description'],
      relationshipType: json['relationshipType'],
    );
  }

  // Método para convertir una instancia de Edge a JSON
  Map<String, dynamic> toJson() {
    return {
      'fromNodeId': fromNodeId,
      'toNodeId': toNodeId,
      'label': label,
      'description': description,
      'relationshipType': relationshipType,
    };
  }
}