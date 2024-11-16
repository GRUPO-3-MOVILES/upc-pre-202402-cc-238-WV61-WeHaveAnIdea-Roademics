import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:roademics/core/utils/constants/app_constants.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/profile/remote/profile_dto.dart';
import 'package:roademics/shared/domain/token_storage.dart';
import 'dart:developer' as developer;

class ProfileService {
  Future<GenericResource<ProfileDto>> getProfileById(
      {required String id}) async {
    try {
      final String? token = await TokenStorage.getToken();
      if (token == null) {
        developer.log(
            "ProfileService: No token found for single profile retrieval.");
        return const Error('Authorization token is missing');
      }

      http.Response response = await http.get(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        return Success(ProfileDto.fromJson(jsonDecode(response.body)));
      } else {
        return const Error('Failed to load profile');
      }
    } catch (e) {
      return Error('An error occurred: $e');
    }
  }

  Future<GenericResource<List<ProfileDto>>> getAllProfiles() async {
    try {
      final String? token = await TokenStorage.getToken();
      if (token == null) {
        developer.log("ProfileService: No token found for profile retrieval.");
        return const Error('Authorization token is missing');
      }

      http.Response response = await http.get(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<ProfileDto> profiles =
            body.map((dynamic item) => ProfileDto.fromJson(item)).toList();
        return Success(profiles);
      } else {
        return const Error('Failed to load profiles');
      }
    } catch (e) {
      return Error('An error occurred: $e');
    }
  }

  Future<GenericResource<ProfileDto>> createProfile({
    required String city,
    required String state,
    required String country,
    required String zipCode,
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String biography,
    required String profileType,
  }) async {
    try {
      final String? token = await TokenStorage.getToken();
      if (token == null) {
        developer.log("ProfileService: No token found for profile creation.");
        return const Error('Authorization token is missing');
      }

      developer.log(
          "ProfileService: Sending profile creation request for email $email");
      http.Response response = await http.post(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          'city': city,
          'state': state,
          'country': country,
          'zipCode': zipCode,
          'phoneNumber': phoneNumber,
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'dateOfBirth': dateOfBirth.toIso8601String(),
          'biography': biography,
          'profileType': profileType,
        }),
      );

      if (response.statusCode == 201) {
        developer
            .log("ProfileService: Profile created successfully for $email");
        return Success(ProfileDto.fromJson(jsonDecode(response.body)));
      } else {
        developer.log(
            "ProfileService: Profile creation failed for $email. Response: ${response.body}");
        return Error('Failed to create profile: ${response.body}');
      }
    } catch (e) {
      developer.log(
          "ProfileService: Error occurred during profile creation for $email. Error: $e");
      return Error('An error occurred: $e');
    }
  }

  Future<GenericResource<ProfileDto>> updateProfile({
    required String id,
    required String city,
    required String state,
    required String country,
    required String zipCode,
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String biography,
    required String profileType,
  }) async {
    try {
      final String? token = await TokenStorage.getToken();
      if (token == null) {
        developer.log("ProfileService: No token found for profile update.");
        return const Error('Authorization token is missing');
      }

      http.Response response = await http.put(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          'id': id,
          'city': city,
          'state': state,
          'country': country,
          'zipCode': zipCode,
          'phoneNumber': phoneNumber,
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'dateOfBirth': dateOfBirth.toIso8601String(),
          'biography': biography,
          'profileType': profileType,
        }),
      );

      if (response.statusCode == 200) {
        return Success(ProfileDto.fromJson(jsonDecode(response.body)));
      } else {
        return const Error('Failed to update profile');
      }
    } catch (e) {
      return Error('An error occurred: $e');
    }
  }
}
