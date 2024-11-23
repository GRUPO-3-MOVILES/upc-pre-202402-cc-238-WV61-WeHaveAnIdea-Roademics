import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';

abstract class GetRoadmapsState {
  const GetRoadmapsState();
}

class GetRoadmapsInitial extends GetRoadmapsState {
  const GetRoadmapsInitial();
}

class GetRoadmapsLoading extends GetRoadmapsState {
  const GetRoadmapsLoading();
}

class GetRoadmapsSuccess extends GetRoadmapsState {
  final List<Roadmap> roadmaps;

  const GetRoadmapsSuccess({required this.roadmaps});
}

class GetRoadmapsError extends GetRoadmapsState {
  final String message;

  const GetRoadmapsError({required this.message});
}
