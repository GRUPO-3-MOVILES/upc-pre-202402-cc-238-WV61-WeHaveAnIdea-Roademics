import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:roademics/domain/roadmaps/repositories/roadmaps_repository.dart';

class GenerateRoadmapWithAI {
  final RoadmapRepository repository;

  GenerateRoadmapWithAI(this.repository);

  Future<Roadmap> call(String userId, String prompt) async {
    if (userId.isEmpty) {
      throw ArgumentError('El ID del usuario no puede estar vacío.');
    }
    if (prompt.isEmpty) {
      throw ArgumentError('El prompt para la IA no puede estar vacío.');
    }

    // Llama a la API de IA y crea el roadmap con los datos retornados
    final generatedRoadmap = await repository.fetchRoadmapByTitle(prompt); // Este es un ejemplo, ajusta la lógica.
    return generatedRoadmap;
  }
}
