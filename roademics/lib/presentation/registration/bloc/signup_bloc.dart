import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/registration/repository/regis_repository.dart';
import 'package:roademics/domain/registration/entities/registered_user.dart';
import 'package:roademics/presentation/registration/bloc/signup_event.dart';
import 'package:roademics/presentation/registration/bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupInitial()) {
    on<SignupSubmitted>((event, emit) async {
      emit(const SignupLoading());
      GenericResource<RegisteredUser> result =
          (await RegistrationRepository().register(
        event.username,
        event.password,
      ));

      if (result is Success) {
        emit(SignupSuccess(user: result.data!));
      } else {
        emit(SignupError(message: result.message!));
      }
    });
  }
}
