import 'package:roademics/domain/roadmaps/repositories/roadmaps_repository.dart';

class DeleteRoadmap {
  final RoadmapRepository repository;

  DeleteRoadmap(this.repository);

  Future<void> call(String roadmapId) async {
    if (roadmapId.isEmpty) {
      throw ArgumentError('El ID del roadmap no puede estar vacío.');
    }
    await repository.deleteRoadmap(roadmapId);
  }
}
