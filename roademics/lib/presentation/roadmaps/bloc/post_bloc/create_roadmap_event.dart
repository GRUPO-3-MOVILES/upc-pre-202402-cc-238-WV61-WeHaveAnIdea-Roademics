abstract class CreateRoadmapEvent {
  const CreateRoadmapEvent();
}

class RoadmapSubmitted extends CreateRoadmapEvent {
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final String aiInteractionId;

  const RoadmapSubmitted({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.aiInteractionId,
  });
}
