import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:roademics/core/utils/constants/app_constants.dart';
import 'package:roademics/domain/authentication/entities/auth_entity.dart';
import 'package:roademics/domain/authentication/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final String baseUrl = AppConstants.baseUrl;

  @override
  Future<AuthUser> signUp(
      String username, String password, List<String> roles) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/authentication/sign-up'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
        'roles': roles,
      }),
    );

    if (response.statusCode == 200) {
      return AuthUser.fromJson(json.decode(response.body));
    } else {
      throw HttpException(
          'Error al registrar el usuario: ${response.reasonPhrase}');
    }
  }

  @override
  Future<AuthUser> signIn(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/authentication/sign-in'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return AuthUser.fromJson(json.decode(response.body));
    } else {
      throw HttpException('Error al iniciar sesión: ${response.reasonPhrase}');
    }
  }
}
