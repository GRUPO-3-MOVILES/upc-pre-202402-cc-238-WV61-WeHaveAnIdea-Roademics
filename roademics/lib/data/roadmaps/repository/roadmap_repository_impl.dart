import 'package:roademics/data/roadmaps/remote/roadmaps_model.dart';
import 'package:roademics/data/roadmaps/remote/node_model.dart';
import 'package:roademics/data/roadmaps/remote/edge_model.dart';
import 'package:roademics/data/roadmaps/remote/roadmaps_service.dart';
import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:roademics/domain/roadmaps/entities/node_entity.dart';
import 'package:roademics/domain/roadmaps/entities/edge_entity.dart';
import 'package:roademics/domain/roadmaps/repositories/roadmaps_repository.dart';

class RoadmapRepositoryImpl implements RoadmapsRepository {
  final RoadmapsService roadmapsService;

  RoadmapRepositoryImpl(this.roadmapsService);

  @override
  Future<Roadmap?> getRoadmapById(String roadmapId) async {
    final roadmapData = await roadmapsService.getRoadmapById(roadmapId);
    if (roadmapData == null) return null;

    return _convertToEntity(roadmapData);
  }

  @override
  Future<List<Roadmap>> getRoadmapsByUserId(String userId) async {
    final roadmapsData = await roadmapsService.getRoadmapsByUserId(userId);
    return roadmapsData.map((data) => _convertToEntity(data)).toList();
  }

  @override
  Future<Roadmap> createRoadmap(Roadmap roadmap) async {
    final roadmapModel = _convertToModel(roadmap);
    final createdRoadmap = await roadmapsService.createRoadmap(roadmapModel);
    return _convertToEntity(createdRoadmap);
  }

  @override
  Future<void> updateRoadmap(String roadmapId, Roadmap roadmap) async {
    final roadmapModel = _convertToModel(roadmap);
    await roadmapsService.updateRoadmap(roadmapId, roadmapModel);
  }

  @override
  Future<void> deleteRoadmap(String roadmapId) async {
    await roadmapsService.deleteRoadmap(roadmapId);
  }

  // Convierte un RoadmapModel (data) a Roadmap (domain)
  Roadmap _convertToEntity(RoadmapModel model) {
    return Roadmap(
      id: model.id,
      ownerId: model.ownerId,
      title: model.title,
      description: model.description,
      nodes: model.nodes.map((node) => Node(
        nodeId: node.nodeId,
        title: node.title,
        description: node.description,
        isStartNode: node.isStartNode,
        isEndNode: node.isEndNode,
      )).toList(),
      edges: model.edges.map((edge) => Edge(
        fromNodeId: edge.fromNodeId,
        toNodeId: edge.toNodeId,
        label: edge.label,
        description: edge.description,
        relationshipType: edge.relationshipType,
      )).toList(),
      isCompleted: model.isCompleted,
    );
  }

  // Convierte un Roadmap (domain) a RoadmapModel (data) para envío a la API
  RoadmapModel _convertToModel(Roadmap roadmap) {
    return RoadmapModel(
      id: roadmap.id,
      ownerId: roadmap.ownerId,
      title: roadmap.title,
      description: roadmap.description,
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
      isCompleted: roadmap.isCompleted,
    );
  }
}
