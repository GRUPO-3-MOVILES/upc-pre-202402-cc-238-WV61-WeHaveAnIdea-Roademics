import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:roademics/domain/roadmaps/repositories/roadmaps_repository.dart';

class GetRoadmapsByUserId {
  final RoadmapRepository repository;

  GetRoadmapsByUserId(this.repository);

  Future<List<Roadmap>> call(String userId) async {
    if (userId.isEmpty) {
      throw ArgumentError('El ID del usuario no puede estar vacío.');
    }
    return await repository.fetchRoadmapsByUserId(userId);
  }
}
