import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:roademics/core/utils/constants/app_constants.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/authentication/remote/auth_request.dart';
import 'package:roademics/data/authentication/remote/user_dto.dart';

class AuthService {
  Future<GenericResource<UserDto>> login(
      {required String username, required String password}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${AppConstants.baseUrl}${AppConstants.auth}/sign-in'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              UserRequest(username: username, password: password).toMap()));
      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Success(UserDto.fromJson(json));
      } else {
        return Error(response.statusCode.toString());
      }
    } catch (e) {
      return Error('An exception has ocurred in auth service ${e.toString()}');
    }
  }

  void register({required String username, required String password}) {
    http.post(Uri.parse('${AppConstants.baseUrl}${AppConstants.auth}/sign-up'),
        headers: {'Content-Type': 'application/json'});
  }
}
