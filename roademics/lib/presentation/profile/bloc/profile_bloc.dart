import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/profile/repository/profile_repository.dart';
import 'package:roademics/presentation/profile/bloc/profile_event.dart';
import 'package:roademics/presentation/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileInitial()) {
    on<CreateProfile>((event, emit) async {
      emit(const ProfileLoading());
      final result = await ProfileRepository().createProfile(
        event.city,
        event.state,
        event.country,
        event.zipCode,
        event.phoneNumber,
        event.email,
        event.firstName,
        event.lastName,
        event.dateOfBirth,
        event.biography,
        event.profileType,
      );

      if (result is Success) {
        emit(ProfileSuccess(profile: result.data!));
      } else {
        emit(ProfileError(message: result.message!));
      }
    });
  }
}
