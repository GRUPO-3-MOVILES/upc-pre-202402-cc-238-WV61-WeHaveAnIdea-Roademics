import 'package:roademics/data/roadmaps/remote/roadmaps_model.dart';
import 'package:roademics/data/roadmaps/remote/edge_model.dart';
import 'package:roademics/data/roadmaps/remote/node_model.dart';
import 'package:roademics/domain/roadmaps/entities/edge_entity.dart';
import 'package:roademics/domain/roadmaps/entities/node_entity.dart';
import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:http/http.dart' as http;
import 'package:roademics/domain/roadmaps/repositories/roadmaps_repository.dart';
import 'dart:convert';
import 'package:roademics/core/utils/constants/app_constants.dart';
class RoadmapRepositoryImpl implements RoadmapRepository {
@override
Future<Roadmap> fetchRoadmap(String roadmapId) async {
  final response = await http.get(Uri.parse(
      '${AppConstants.baseUrl}/${AppConstants.roadmaps}/$roadmapId'));
  if (response.statusCode == 200) {
    final roadmapModel = RoadmapModel.fromJson(jsonDecode(response.body));
    return _convertToEntity(roadmapModel); 
  } else {
    throw Exception('Error al cargar el roadmap');
  }
}

@override
Future<List<Roadmap>> fetchRoadmapsByUserId(String userId) async {
  final response = await http.get(Uri.parse('${AppConstants.baseUrl}/${AppConstants.roadmaps}/user/$userId'));
  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    return data.map((item) => _convertToEntity(RoadmapModel.fromJson(item))).toList(); // Convierte cada elemento
  } else {
    throw Exception('Error al cargar los roadmaps del usuario');
  }
}


@override
Future<Roadmap> fetchRoadmapByTitle(String title) async {
  final response = await http.get(Uri.parse('${AppConstants.baseUrl}/${AppConstants.roadmaps}/title/$title'));
  if (response.statusCode == 200) {
    final roadmapModel = RoadmapModel.fromJson(jsonDecode(response.body));
    return _convertToEntity(roadmapModel); // Usa _convertToEntity aquí
  } else {
    throw Exception('Error al cargar el roadmap por título');
  }
}

@override
Future<Roadmap> createRoadmap(Roadmap roadmap) async {
  // Convierte Roadmap (entidad de domain) a RoadmapModel (modelo de data)
  final roadmapModel = RoadmapModel.fromEntity(roadmap);

  final response = await http.post(
    Uri.parse('${AppConstants.baseUrl}/${AppConstants.roadmaps}/create'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(roadmapModel.toJson()), // Usa toJson de RoadmapModel
  );

  if (response.statusCode == 200) {
    // Decodifica y convierte la respuesta JSON en una instancia de RoadmapModel
    final roadmapModel = RoadmapModel.fromJson(jsonDecode(response.body));
    return _convertToEntity(roadmapModel); // Convierte el modelo de respuesta a entidad de domain
  } else {
    throw Exception('Error al crear el roadmap');
  }
}

@override
Future<Roadmap> updateRoadmap(
    String roadmapId, String title, String description) async {
  final response = await http.put(
    Uri.parse('${AppConstants.baseUrl}/${AppConstants.roadmaps}/update'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'roadmapId': roadmapId,
      'title': title,
      'description': description,
    }),
  );
  if (response.statusCode == 200) {
    final roadmapModel = RoadmapModel.fromJson(jsonDecode(response.body));
    return _convertToEntity(roadmapModel); // Usa _convertToEntity aquí
  } else {
    throw Exception('Error al actualizar el roadmap');
  }
}

  @override
  Future<void> deleteRoadmap(String roadmapId) async {
    final response = await http.delete(Uri.parse('$AppConstants.baseUrl/$roadmapId'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el roadmap');
    }
  }

Roadmap _convertToEntity(RoadmapModel model) {
  return Roadmap(
    id: model.id,
    ownerId: model.ownerId,
    title: model.title,
    description: model.description,
    completed: model.isCompleted,
    nodes: model.nodes.map((nodeModel) => Node(
      nodeId: nodeModel.nodeId,
      title: nodeModel.title,
      description: nodeModel.description,
      isStartNode: nodeModel.isStartNode,
      isEndNode: nodeModel.isEndNode,
    )).toList(),
    edges: model.edges.map((edgeModel) => Edge(
      fromNodeId: edgeModel.fromNodeId,
      toNodeId: edgeModel.toNodeId,
      label: edgeModel.label,
      description: edgeModel.description,
      relationshipType: edgeModel.relationshipType,
    )).toList(),
  );
}



}
