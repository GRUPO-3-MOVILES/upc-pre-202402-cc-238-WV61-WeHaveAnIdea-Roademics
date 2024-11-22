import 'package:bloc/bloc.dart';
import 'package:roademics/domain/profiles/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<UpdatePhoneNumber>(_onUpdatePhoneNumber);
    on<UpdateEmailAddress>(_onUpdateEmailAddress);
    on<UpdatePassword>(_onUpdatePassword);
    on<DeleteAccount>(_onDeleteAccount);
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await profileRepository.getProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final updatedProfile = await profileRepository.updateProfile(event.profile);
      emit(ProfileLoaded(profile: updatedProfile));
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }

  void _onUpdatePhoneNumber(UpdatePhoneNumber event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final updatedProfile = await profileRepository.updatePhoneNumber(event.phoneNumber);
      emit(ProfileLoaded(profile: updatedProfile));
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }

  void _onUpdateEmailAddress(UpdateEmailAddress event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final updatedProfile = await profileRepository.updateEmailAddress(event.emailAddress);
      emit(ProfileLoaded(profile: updatedProfile));
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }

  void _onUpdatePassword(UpdatePassword event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final result = await profileRepository.updatePassword(
        event.currentPassword,
        event.newPassword,
      );
      if (result) {
        emit(ProfileSuccess(message: 'Contraseña actualizada correctamente'));
      } else {
        emit(ProfileError(error: 'Error al actualizar la contraseña. Revise si las contraseñas ingresadas son adecuadas.'));
      }
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }

  void _onDeleteAccount(DeleteAccount event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final result = await profileRepository.deleteAccount(event.password);
      if (result) {
        emit(AccountDeleted());
      } else {
        emit(ProfileError(error: 'Error al eliminar la cuenta. Contraseña incorrecta.'));
      }
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }
}