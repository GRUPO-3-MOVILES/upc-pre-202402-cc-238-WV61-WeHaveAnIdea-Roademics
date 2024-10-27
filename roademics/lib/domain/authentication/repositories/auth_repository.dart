import 'package:roademics/domain/authentication/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<AuthUser> signUp(String username, String password, List<String> roles);
  Future<AuthUser> signIn(String username, String password);
}
