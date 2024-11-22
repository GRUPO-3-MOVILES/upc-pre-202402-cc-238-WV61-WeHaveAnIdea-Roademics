import 'dart:convert';
import 'dart:io';
import 'package:roademics/core/utils/constants/app_constants.dart';
import 'package:roademics/domain/profiles/entities/profile_model.dart';
import 'package:http/http.dart' as http;


class ProfileService {
  Future<ProfileModel> getProfile() async {
    final url = Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}');
    http.Response response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return ProfileModel.fromJson(json);
    }
    throw Exception('Error al obtener el perfil');
  }

  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    final url = Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}/${profile.id}');
    http.Response response = await http.put(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(profile.toJson()),
    );
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return ProfileModel.fromJson(json);
    }
    throw Exception('Error al actualizar el perfil');
  }

  Future<bool> updatePassword(String currentPassword, String newPassword) async {
    final url = Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}/update-password');
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      }),
    );
    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }

  Future<bool> deleteAccount(String password) async {
    final url = Uri.parse('${AppConstants.baseUrl}${AppConstants.profiles}/delete-account');
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'password': password,
      }),
    );
    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }
}