import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';

abstract class CreateRoadmapState {
  const CreateRoadmapState();
}

class CreateRoadmapInitial extends CreateRoadmapState {
  const CreateRoadmapInitial();
}

class CreateRoadmapLoading extends CreateRoadmapState {
  const CreateRoadmapLoading();
}

class CreateRoadmapSuccess extends CreateRoadmapState {
  final Roadmap roadmap;

  const CreateRoadmapSuccess({required this.roadmap});
}

class CreateRoadmapError extends CreateRoadmapState {
  final String message;

  const CreateRoadmapError({required this.message});
}
