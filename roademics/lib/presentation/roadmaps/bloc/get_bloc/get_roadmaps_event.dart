abstract class GetRoadmapsEvent {
  const GetRoadmapsEvent();
}

class RoadmapRequested extends GetRoadmapsEvent {
  final String ownerId;

  const RoadmapRequested({required this.ownerId});
}
