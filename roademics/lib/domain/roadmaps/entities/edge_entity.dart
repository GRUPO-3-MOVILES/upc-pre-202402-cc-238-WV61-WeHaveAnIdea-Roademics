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
  }){
    // Validaciones básicas
    if (fromNodeId == toNodeId) {
      throw ArgumentError('El Edge no puede conectar un nodo consigo mismo.');
    }
    if (label.isEmpty) {
      throw ArgumentError('El Edge debe tener un label.');
    }
    if (relationshipType.isEmpty) {
      throw ArgumentError('El Edge debe tener un tipo de relación.');
    }
  }

  factory Edge.fromJson(Map<String, dynamic> json) {
    return Edge(
      fromNodeId: json['fromNodeId'],
      toNodeId: json['toNodeId'],
      label: json['label'],
      description: json['description'],
      relationshipType: json['relationshipType'],
    );
  }
}
