import 'package:roademics/domain/authentication/entities/user.dart';

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
  final User user;

  const LoginSuccess({required this.user});
}

class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});
}
