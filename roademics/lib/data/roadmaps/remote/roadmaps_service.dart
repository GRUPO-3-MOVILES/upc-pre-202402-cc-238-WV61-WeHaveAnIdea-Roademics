import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:roademics/data/roadmaps/remote/roadmaps_model.dart';
import 'package:roademics/core/utils/constants/app_constants.dart';

class RoadmapsService {
  final String baseUrl = AppConstants.baseUrl;
  final String token; // Token de autenticación, si aplica

  RoadmapsService({required this.token});

  // GET: Obtener un roadmap por ID
  Future<Roadmap?> getRoadmapById(String roadmapId) async {
    final response = await http.get(
      Uri.parse('$baseUrl${AppConstants.roadmaps}/$roadmapId'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      return Roadmap.fromJson(json.decode(response.body));
    } else {
      throw const HttpException('Error al obtener el roadmap');
    }
  }

  // GET: Obtener roadmaps por UserID
  Future<List<Roadmap>> getRoadmapsByUserId(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl${AppConstants.roadmaps}/user/$userId'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Roadmap.fromJson(item)).toList();
    } else {
      throw const HttpException('Error al obtener los roadmaps por UserID');
    }
  }

  // POST: Crear un nuevo roadmap
  Future<Roadmap> createRoadmap(Roadmap roadmap) async {
    final response = await http.post(
      Uri.parse('$baseUrl${AppConstants.roadmaps}/create'),
      headers: _headers,
      body: json.encode(roadmap.toJson()),
    );
    if (response.statusCode == 201) {
      return Roadmap.fromJson(json.decode(response.body));
    } else {
      throw const HttpException('Error al crear el roadmap');
    }
  }

  // PUT: Actualizar un roadmap existente
  Future<void> updateRoadmap(String roadmapId, Roadmap roadmap) async {
    final response = await http.put(
      Uri.parse('$baseUrl${AppConstants.roadmaps}/update'),
      headers: _headers,
      body: json.encode({
        'id': roadmapId,
        ...roadmap.toJson(),
      }),
    );
    if (response.statusCode != 200) {
      throw const HttpException('Error al actualizar el roadmap');
    }
  }

  // DELETE: Eliminar un roadmap por ID
  Future<void> deleteRoadmap(String roadmapId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl${AppConstants.roadmaps}/$roadmapId'),
      headers: _headers,
    );
    if (response.statusCode != 200) {
      throw const HttpException('Error al eliminar el roadmap');
    }
  }

  // Encabezados comunes para autenticación y tipo de contenido
  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Ajustar si necesitas autenticación
      };
}
