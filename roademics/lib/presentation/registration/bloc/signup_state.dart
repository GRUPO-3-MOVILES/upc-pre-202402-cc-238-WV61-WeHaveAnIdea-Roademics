import 'package:roademics/domain/registration/entities/registered_user.dart';

abstract class SignupState {
  const SignupState();
}

class SignupInitial extends SignupState {
  const SignupInitial();
}

class SignupLoading extends SignupState {
  const SignupLoading();
}

class SignupSuccess extends SignupState {
  final RegisteredUser user;

  const SignupSuccess({required this.user});
}

class SignupError extends SignupState {
  final String message;

  const SignupError({required this.message});
}
