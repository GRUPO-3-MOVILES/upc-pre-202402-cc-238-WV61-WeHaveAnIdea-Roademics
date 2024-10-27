import 'package:roademics/data/roadmaps/remote/roadmaps_model.dart';

abstract class RoadmapsRepository {
  Future<Roadmap?> getRoadmapById(String roadmapId);
  Future<List<Roadmap>> getRoadmapsByUserId(String userId);
  Future<Roadmap> createRoadmap(Roadmap roadmap);
  Future<void> updateRoadmap(String roadmapId, Roadmap roadmap);
  Future<void> deleteRoadmap(String roadmapId);
}
