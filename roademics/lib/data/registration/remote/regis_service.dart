import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:roademics/core/utils/constants/app_constants.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/profiles/remote/profile_dto.dart';
import 'package:roademics/data/registration/remote/regis_request.dart';

class RegisService {

  Future<GenericResource<ProfileDto>> register(RegisRequest request) async {
    try {
      http.Response response = await http.post(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toMap()),
      );

      if (response.statusCode == 201) {
        return Success(ProfileDto.fromJson(jsonDecode(response.body)));
      } else {
        return const Error('Failed to register');
      }
    } catch (e) {
      return Error('An error occurred: $e');
    }
  }
  
  Future<GenericResource<ProfileDto>> createProfile(RegisRequest request) async {
    try {
      http.Response response = await http.post(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toMap()),
      );

      if (response.statusCode == 201) {
        return Success(ProfileDto.fromJson(jsonDecode(response.body)));
      } else {
        return const Error('Failed to create profile');
      }
    } catch (e) {
      return Error('An error occurred: $e');
    }
  }

  Future<GenericResource<ProfileDto>> updateProfile(String id, RegisRequest request) async {
    try {
      http.Response response = await http.put(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toMap()),
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

  Future<GenericResource<ProfileDto>> getProfileById(String id) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}/$id'),
        headers: {'Content-Type': 'application/json'},
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
      http.Response response = await http.get(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<ProfileDto> profiles = body.map((dynamic item) => ProfileDto.fromJson(item)).toList();
        return Success(profiles);
      } else {
        return const Error('Failed to load profiles');
      }
    } catch (e) {
      return Error('An error occurred: $e');
    }
  }
}