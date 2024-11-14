import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/authentication/repository/auth_repository.dart';
import 'package:roademics/domain/authentication/entities/auth_user.dart';
import 'package:roademics/presentation/authentication/bloc/login_event.dart';
import 'package:roademics/presentation/authentication/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(const LoginLoading());
      GenericResource<AuthUser> result =
          await AuthRepository().login(event.username, event.password);

      if (result is Success) {
        emit(LoginSuccess(user: result.data!));
      } else {
        emit(LoginError(message: result.message!));
      }
    });
  }
}
