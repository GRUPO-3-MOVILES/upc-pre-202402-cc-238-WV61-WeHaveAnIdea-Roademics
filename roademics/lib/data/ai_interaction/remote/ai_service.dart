import 'package:roademics/core/utils/constants/app_constants.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/ai_interaction/remote/ai_dto.dart';
import 'package:roademics/shared/domain/token_storage.dart';
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:http/http.dart' as http;

class AiService {
  Future<GenericResource<AiDto>> SendPrompt({required String prompt}) async {
    try {
      final String? token = await TokenStorage.getToken();
      if (token == null) {
        developer.log("AiService: No token found for single prompt retrieval.");
        return const Error('Authorization token is missing');
      }

      developer.log(
          "AiService: Sending prompt retrieval request for prompt $prompt");

      http.Response response = await http.post(
          Uri.parse(
              '${AppConstants.baseUrl}${AppConstants.interactions}/send-prompt'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
          body: jsonEncode({'prompt': prompt}));

      developer.log("AiService: Response Body: ${response.body}");
      developer.log("AiService: Response Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        developer
            .log("AiService: Prompt retrieved successfully for prompt $prompt");
        return Success(AiDto.fromJson(jsonDecode(response.body)));
      } else {
        developer.log(
            "AiService: Prompt retrieval failed for prompt $prompt. Response: ${response.body}");
        return const Error('Failed to load prompt');
      }
    } catch (e) {
      developer.log(
          "AiService: Error occurred during prompt retrieval for prompt $prompt. Error: $e");
      return Error('An error occurred: $e');
    }
  }
}
