import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:roademics/core/utils/constants/app_constants.dart';
import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';

class RoadmapsService {
  final String baseUrl = AppConstants.baseUrl;
  final String? token; // Token de autenticación opcional

  RoadmapsService({this.token});

  // Método auxiliar para manejo de errores HTTP
  void _handleHttpError(http.Response response, String action) {
    throw HttpException(
        'Error al $action: ${response.reasonPhrase} (Status: ${response.statusCode})');
  }

  // GET: Obtener un roadmap por ID
  Future<Roadmap?> getRoadmapById(String roadmapId) async {
    final response = await http.get(
      Uri.parse('$baseUrl${AppConstants.roadmaps}/$roadmapId'),
      headers: _headers,
    );
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return Roadmap.fromJson(json.decode(response.body));
    } else {
      _handleHttpError(response, 'obtener el roadmap');
    }
    return null; // Agregar este retorno para cubrir todos los caminos
  }

  // GET: Obtener roadmaps por UserID
  Future<List<Roadmap>> getRoadmapsByUserId(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl${AppConstants.roadmaps}/user/$userId'),
      headers: _headers,
    );
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Roadmap.fromJson(item)).toList();
    } else {
      _handleHttpError(response, 'obtener los roadmaps por UserID');
    }
    return []; // Agregar este retorno para listas vacías en caso de error
  }

  // POST: Crear un nuevo roadmap
  Future<Roadmap> createRoadmap(Roadmap roadmap) async {
    final response = await http.post(
      Uri.parse('$baseUrl${AppConstants.roadmaps}/create'),
      headers: _headers,
      body: json.encode(roadmap.toJson()),
    );
    if ((response.statusCode == 200 || response.statusCode == 201) &&
        response.body.isNotEmpty) {
      return Roadmap.fromJson(json.decode(response.body));
    } else {
      _handleHttpError(response, 'crear el roadmap');
    }
    throw const HttpException(
        'Error inesperado al crear el roadmap'); // Lanzar excepción explícita en caso de error inesperado
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
      _handleHttpError(response, 'actualizar el roadmap');
    }
    return; // Declaración explícita de retorno para funciones void
  }

  // DELETE: Eliminar un roadmap por ID
  Future<void> deleteRoadmap(String roadmapId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl${AppConstants.roadmaps}/$roadmapId'),
      headers: _headers,
    );
    if (response.statusCode != 200) {
      _handleHttpError(response, 'eliminar el roadmap');
    }
    return; // Declaración explícita de retorno para funciones void
  }

  // Encabezados comunes para autenticación y tipo de contenido
  Map<String, String> get _headers {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}
