import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/authentication/remote/auth_service.dart';
import 'package:roademics/data/authentication/remote/user_dto.dart';
import 'package:roademics/domain/authentication/entities/auth_user.dart';
import 'package:roademics/shared/domain/token_storage.dart';
import 'dart:developer' as developer;

class AuthRepository {
  Future<GenericResource<AuthUser>> login(
      String username, String password) async {
    GenericResource<UserDto> result =
        await AuthService().login(username: username, password: password);

    if (result is Success) {
      developer.log("AuthRepository: Token received: ${result.data!.token}");
      TokenStorage.saveToken(result.data!.token);
      developer.log("AuthRepository: Token saved: ${TokenStorage.getToken()}");
      return Success(result.data!.toUser());
    } else {
      return Error(result.message!);
    }
  }
}
