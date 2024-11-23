class RoadmapRequest {
  String id;
  String ownerId;
  String title;
  String description;
  String aiInteractionId;
  List<NodeRequest>? nodes;
  List<EdgeRequest>? edges;

  RoadmapRequest({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.aiInteractionId,
    this.nodes,
    this.edges,
  });

  Map<String, dynamic> toRoadmapMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'aiInteractionId': aiInteractionId,
      'nodes': nodes?.map((node) => node.toNodeMap()).toList() ?? [],
      'edges': edges?.map((edge) => edge.toEdgeMap()).toList() ?? [],
    };
  }
}

class NodeRequest {
  String nodeId;
  String title;
  String description;
  bool isStartNode;
  bool isEndNode;

  NodeRequest({
    required this.nodeId,
    required this.title,
    required this.description,
    required this.isStartNode,
    required this.isEndNode,
  });

  Map<String, dynamic> toNodeMap() {
    return {
      'nodeId': nodeId,
      'title': title,
      'description': description,
      'isStartNode': isStartNode,
      'isEndNode': isEndNode,
    };
  }
}

class EdgeRequest {
  String edgeId;
  String sourceNodeId;
  String targetNodeId;
  String description;

  EdgeRequest({
    required this.edgeId,
    required this.sourceNodeId,
    required this.targetNodeId,
    required this.description,
  });

  Map<String, dynamic> toEdgeMap() {
    return {
      'edgeId': edgeId,
      'sourceNodeId': sourceNodeId,
      'targetNodeId': targetNodeId,
      'description': description,
    };
  }
}
