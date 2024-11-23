
import 'package:roademics/domain/authentication/entities/auth_user.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final AuthUser user;

  const LoginSuccess({required this.user});
}

class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});
}
