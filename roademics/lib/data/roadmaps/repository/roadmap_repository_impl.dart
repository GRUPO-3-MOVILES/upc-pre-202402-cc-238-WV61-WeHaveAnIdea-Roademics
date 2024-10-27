import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:http/http.dart' as http;
import 'package:roademics/domain/roadmaps/repositories/roadmaps_repository.dart';
import 'dart:convert';

class RoadmapRepositoryImpl implements RoadmapRepository {
  @override
  Future<Roadmap> fetchRoadmap(String roadmapId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/$roadmapId')); // Agrega el endpoint correcto causaaa
    if (response.statusCode == 200) {
      return Roadmap.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar el roadmap');
    }
  }

  @override
  Future<List<Roadmap>> fetchRoadmapsByUserId(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$userId'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Roadmap.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar los roadmaps del usuario');
    }
  }

  @override
  Future<Roadmap> fetchRoadmapByTitle(String title) async {
    final response = await http.get(Uri.parse('$baseUrl/title/$title'));
    if (response.statusCode == 200) {
      return Roadmap.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar el roadmap por título');
    }
  }

  @override
  Future<Roadmap> createRoadmap(Roadmap roadmap) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(roadmap.toJson()),
    );
    if (response.statusCode == 200) {
      return Roadmap.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear el roadmap');
    }
  }

  @override
  Future<Roadmap> updateRoadmap(
      String roadmapId, String title, String description) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'roadmapId': roadmapId,
        'title': title,
        'description': description,
      }),
    );
    if (response.statusCode == 200) {
      return Roadmap.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al actualizar el roadmap');
    }
  }

  @override
  Future<void> deleteRoadmap(String roadmapId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$roadmapId'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el roadmap');
    }
  }
}
