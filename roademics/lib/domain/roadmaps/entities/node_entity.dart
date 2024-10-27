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

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      nodeId: json['nodeId'],
      title: json['title'],
      description: json['description'],
      isStartNode: json['isStartNode'],
      isEndNode: json['isEndNode'],
    );
  }
}
