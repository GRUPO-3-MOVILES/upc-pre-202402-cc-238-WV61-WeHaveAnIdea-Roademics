import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/registration/remote/regis_dto.dart';
import 'package:roademics/data/registration/remote/regis_service.dart';
import 'package:roademics/domain/registration/entities/registered_user.dart';
import 'package:roademics/shared/domain/token_storage.dart';

class RegistrationRepository {
  final RegistrationService _registrationService = RegistrationService();

  Future<GenericResource<RegisteredUser>> register(
    String usernam,
    String password,
  ) async {
    final GenericResource<RegistrationDto> result =
        await _registrationService.signUp(
      username: usernam,
      password: password,
    );

    if (result is Success) {
      await TokenStorage.saveToken(result.data!.token);
      return Success(result.data!.toRegisteredUser());
    } else {
      return Error(result.message!);
    }
  }
}
