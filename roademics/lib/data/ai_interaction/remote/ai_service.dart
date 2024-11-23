import 'dart:developer' as developer;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:roademics/core/utils/constants/app_constants.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/ai_interaction/remote/ai_dto.dart';
import 'package:roademics/shared/domain/token_storage.dart';

class AiService {
  Future<GenericResource<AiDto>> sendPrompt({required String prompt}) async {
    try {
      developer.log(
          "AiService: Sending prompt retrieval request for prompt: $prompt");

      final String? token = await TokenStorage.getToken();
      developer.log("AiService: Retrieved token: $token"); // Log token

      if (token == null) {
        developer.log("AiService: Token is missing.");
        return const Error('Authorization token is missing');
      }

      final Uri url = Uri.parse(
          '${AppConstants.baseUrl}${AppConstants.interactions}/send-prompt');
      developer
          .log("AiService: Sending POST request to $url with token: $token");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({'prompt': prompt}),
      );

      developer.log("AiService: Response Code: ${response.statusCode}");
      developer.log("AiService: Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(AiDto.fromJson(jsonDecode(response.body)));
      } else {
        return const Error('Failed to load prompt');
      }
    } catch (e) {
      developer.log("AiService: Error occurred during prompt retrieval - $e");
      return Error('An error occurred: $e');
    }
  }
}
