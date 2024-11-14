import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/authentication/remote/auth_service.dart';
import 'package:roademics/data/authentication/remote/user_dto.dart';
import 'package:roademics/domain/authentication/entities/auth_user.dart';

class AuthRepository {
  Future<GenericResource<AuthUser>> login(
      String username, String password) async {
    GenericResource<UserDto> result =
        await AuthService().login(username: username, password: password);

    if (result is Success) {
      return Success(result.data!.toUser());
    } else {
      return Error(result.message!);
    }
  }
}