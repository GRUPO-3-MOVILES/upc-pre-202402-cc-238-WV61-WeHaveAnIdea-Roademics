import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';

abstract class RoadmapRepository {
  Future<Roadmap> fetchRoadmap(String roadmapId);
  Future<List<Roadmap>> fetchRoadmapsByUserId(String userId);
  Future<Roadmap> fetchRoadmapByTitle(String title);
  Future<Roadmap> createRoadmap(Roadmap roadmap);
  Future<Roadmap> updateRoadmap(
      String roadmapId, String title, String description);
  Future<void> deleteRoadmap(String roadmapId);
}
