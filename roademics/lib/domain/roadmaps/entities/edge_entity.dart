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
}
