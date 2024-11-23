import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:roademics/domain/roadmaps/repositories/roadmaps_repository.dart';

class CreateRoadmap {
  final RoadmapRepository repository;

  CreateRoadmap(this.repository);

  Future<Roadmap> call(Roadmap roadmap) async {
    if (roadmap.title.isEmpty) {
      throw ArgumentError('El título del roadmap no puede estar vacío.');
    }
    if (roadmap.nodes.isEmpty) {
      throw ArgumentError('El roadmap debe contener al menos un nodo.');
    }
    return await repository.createRoadmap(roadmap);
  }
}
