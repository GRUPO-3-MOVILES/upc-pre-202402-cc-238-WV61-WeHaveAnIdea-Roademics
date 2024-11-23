import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:roademics/core/utils/constants/app_constants.dart';
import 'package:roademics/domain/authentication/entities/auth_entity.dart';

class AuthService {
  final String baseUrl = AppConstants.baseUrl;

  // POST: Registro de usuario (sign-up)
  Future<AuthUser> signUp(
      String username, String password, List<String> roles) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/authentication/sign-up'),
      headers: _headers,
      body: json.encode({
        'username': username,
        'password': password,
        'roles': roles,
      }),
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return AuthUser.fromJson(json.decode(response.body));
    } else {
      throw HttpException(
          'Error al registrar el usuario: ${response.reasonPhrase}');
    }
  }

  // POST: Inicio de sesión de usuario (sign-in)
  Future<AuthUser> signIn(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/authentication/sign-in'),
      headers: _headers,
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return AuthUser.fromJson(json.decode(response.body));
    } else {
      throw HttpException('Error al iniciar sesión: ${response.reasonPhrase}');
    }
  }

  // Encabezados comunes para tipo de contenido JSON
  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
      };
}
