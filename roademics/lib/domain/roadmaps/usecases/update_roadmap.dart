import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:roademics/domain/roadmaps/repositories/roadmaps_repository.dart';

class UpdateRoadmap {
  final RoadmapRepository repository;

  UpdateRoadmap(this.repository);

  Future<Roadmap> call(String roadmapId, String title, String description) async {
    if (roadmapId.isEmpty) {
      throw ArgumentError('El ID del roadmap no puede estar vacío.');
    }
    if (title.isEmpty) {
      throw ArgumentError('El título no puede estar vacío.');
    }
    return await repository.updateRoadmap(roadmapId, title, description);
  }
}
