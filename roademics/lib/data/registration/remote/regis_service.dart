import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:roademics/core/utils/constants/app_constants.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/registration/remote/regis_dto.dart';
import 'package:roademics/data/registration/remote/regis_request.dart';
import 'dart:developer' as developer;

class RegistrationService {
  Future<GenericResource<RegistrationDto>> signUp(
      String username, String password) async {
    try {
      developer
          .log("RegistrationService: Sending signup request for $username");

      http.Response userResponse = await http.post(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.auth}/sign-up'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(RegistrationRequest(
          username: username,
          password: password,
        ).toAuthMap()),
      );

      if (userResponse.statusCode == 200 || userResponse.statusCode == 201) {
        developer.log("RegistrationService: Signup successful for $username");
        developer.log(
            "RegistrationService: Signup status code succesfull(${userResponse.statusCode}) Response Body: ${userResponse.body}");
        developer.log(
            "RegistrationService: Response Headers: ${userResponse.headers}");

        final Map<String, dynamic> json = jsonDecode(userResponse.body);
        return Success(RegistrationDto.fromJson(json));
      } else {
        developer.log(
            "RegistrationService: Signup status code failed (${userResponse.statusCode}), Response Body: ${userResponse.body}");
        developer.log(
            "RegistrationService: Response Headers: ${userResponse.headers}");

        return const Error('Failed to sign up');
      }
    } catch (e) {
      developer.log(
          "RegistrationService: Error occurred during signup for $username. Error: $e");
      return Error('An error occurred during sign-up: $e');
    }
  }
}
