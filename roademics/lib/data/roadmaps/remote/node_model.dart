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
  }) {
    assert(nodeId.isNotEmpty, 'El nodeId no puede estar vacío');
    assert(title.isNotEmpty, 'El título no puede estar vacío');
    assert(description.isNotEmpty, 'La descripción no puede estar vacía');
    assert(!(isStartNode && isEndNode),
        'Un nodo no puede ser inicio y fin al mismo tiempo');
  }

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
