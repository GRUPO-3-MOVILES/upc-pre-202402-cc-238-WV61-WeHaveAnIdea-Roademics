import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/roadmaps/remote/roadmap_dto.dart';
import 'package:roademics/data/roadmaps/remote/roadmaps_service.dart';
import 'package:roademics/domain/roadmaps/entities/edge_entity.dart';
import 'package:roademics/domain/roadmaps/entities/node_entity.dart';
import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:roademics/core/utils/constants/app_constants.dart';

class RoadmapRepository {
  final RoadmapsService _roadmapsService = RoadmapsService();

  Future<GenericResource<Roadmap>> createRoadmap({
    required String ownerId,
    required String title,
    required String description,
    required String aiInteractionId,
  }) async {
    GenericResource<RoadmapDto> result = await _roadmapsService.createRoadmap(
      ownerId: ownerId,
      title: title,
      description: description,
      aiInteractionId: aiInteractionId,
    );

    if (result is Success) {
      return Success(result.data!.toRoadmap());
    } else {
      return Error(result.message!);
    }
  }

  Future<GenericResource<List<Roadmap>>> getAllRoadmapsByUserId(
      String userId) async {
    GenericResource<List<RoadmapDto>> result =
        await _roadmapsService.getAllRoadmapsByUserId(userId);

    if (result is Success) {
      List<Roadmap> roadmaps =
          result.data!.map((dto) => dto.toRoadmap()).toList();
      return Success(roadmaps);
    } else {
      return Error(result.message!);
    }
  }
}
