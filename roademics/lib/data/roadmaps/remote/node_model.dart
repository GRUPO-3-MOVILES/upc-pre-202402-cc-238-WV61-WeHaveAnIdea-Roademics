class NodeModel {
  final String nodeId;
  final String title;
  final String description;
  final bool isStartNode;
  final bool isEndNode;

  NodeModel({
    required this.nodeId,
    required this.title,
    required this.description,
    required this.isStartNode,
    required this.isEndNode,
  });

  // Convierte JSON a NodeModel
  factory NodeModel.fromJson(Map<String, dynamic> json) {
    return NodeModel(
      nodeId: json['nodeId'],
      title: json['title'],
      description: json['description'],
      isStartNode: json['isStartNode'],
      isEndNode: json['isEndNode'],
    );
  }

  // Convierte NodeModel a JSON
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
