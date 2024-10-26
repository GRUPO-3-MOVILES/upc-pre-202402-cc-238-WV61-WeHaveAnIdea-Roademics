import 'package:roademics/domain/profiles/entities/profile_model.dart';
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  ProfileLoaded({required this.profile});
}
class ProfileError extends ProfileState {
  final String error;

  ProfileError({required this.error});
}