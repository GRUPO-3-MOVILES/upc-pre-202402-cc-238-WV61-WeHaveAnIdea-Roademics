import 'dart:convert';

import 'package:roademics/core/utils/constants/app_constants.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/roadmaps/remote/roadmap_dto.dart';
import 'package:roademics/shared/domain/token_storage.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class RoadmapsService {
  final String url =
      Uri.parse('${AppConstants.baseUrl}${AppConstants.roadmaps}').toString();

  Future<GenericResource<RoadmapDto>> createRoadmap({
    required String ownerId,
    required String title,
    required String description,
    required String aiInteractionId,
  }) async {
    try {
      developer.log("RoadmapsService: Sending request to create roadmap");

      final String? token = await TokenStorage.getToken();

      if (token == null) {
        developer.log("RoadmapsService: No token found for roadmap creation.");
        return const Error('Authorization token is missing');
      }

      http.Response response = await http.post(
        Uri.parse('$url/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          'ownerId': ownerId,
          'title': title,
          'description': description,
          'aiInteractionId': aiInteractionId,
        }),
      );

      developer.log("RoadmapsService: Response Body: ${response.body}");
      developer
          .log("RoadmapsService: Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        developer.log("RoadmapsService: Roadmap with name $title successfully");
        return Success(RoadmapDto.fromJson(jsonDecode(response.body)));
      } else {
        developer.log(
            "RoadmapsService: Roadmap with name $title creation failed. Response: ${response.body}");
        return const Error('Failed to create roadmap');
      }
    } catch (e) {
      developer.log(
          "RoadmapsService: Error occurred during roadmap creation. Error: $e");
      return Error('An error occurred: $e');
    }
  }

  Future<GenericResource<List<RoadmapDto>>> getAllRoadmapsByUserId(
      String userId) async {
    try {
      developer
          .log("RoadmapsService: Sending request to retrieve all roadmaps");

      final String? token = await TokenStorage.getToken();

      if (token == null) {
        developer.log("RoadmapsService: No token found for roadmap retrieval.");
        return const Error('Authorization token is missing');
      }

      http.Response response = await http.get(
        Uri.parse('$url/user/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      developer.log("RoadmapsService: Response Body: ${response.body}");
      developer
          .log("RoadmapsService: Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        developer.log("RoadmapsService: All roadmaps retrieved successfully");
        List<dynamic> body = jsonDecode(response.body);
        List<RoadmapDto> roadmaps =
            body.map((item) => RoadmapDto.fromJson(item)).toList();
        return Success(roadmaps);
      } else {
        developer.log(
            "RoadmapsService: Roadmaps retrieval failed. Response: ${response.body}");
        return const Error('Failed to load roadmaps');
      }
    } catch (e) {
      developer.log(
          "RoadmapsService: Error occurred during roadmaps retrieval. Error: $e");
      return Error('An error occurred: $e');
    }
  }
}
