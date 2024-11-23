import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:roademics/domain/roadmaps/repositories/roadmaps_repository.dart';

class GetRoadmapById {
  final RoadmapRepository repository;

  GetRoadmapById(this.repository);

  Future<Roadmap> call(String roadmapId) async {
    if (roadmapId.isEmpty) {
      throw ArgumentError('El ID del roadmap no puede estar vacío.');
    }
    return await repository.fetchRoadmap(roadmapId);
  }
}
