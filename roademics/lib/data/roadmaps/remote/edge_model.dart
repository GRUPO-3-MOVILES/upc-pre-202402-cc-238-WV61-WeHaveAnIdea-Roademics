class EdgeModel {
  final String fromNodeId;
  final String toNodeId;
  final String label;
  final String description;
  final String relationshipType;

  EdgeModel({
    required this.fromNodeId,
    required this.toNodeId,
    required this.label,
    required this.description,
    required this.relationshipType,
  });

  // Convierte JSON a EdgeModel
  factory EdgeModel.fromJson(Map<String, dynamic> json) {
    return EdgeModel(
      fromNodeId: json['fromNodeId'],
      toNodeId: json['toNodeId'],
      label: json['label'],
      description: json['description'],
      relationshipType: json['relationshipType'],
    );
  }

  // Convierte EdgeModel a JSON
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
