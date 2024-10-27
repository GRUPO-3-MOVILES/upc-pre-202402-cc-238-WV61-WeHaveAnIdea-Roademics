import 'package:roademics/domain/profiles/entities/profile_model.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}
class UpdateProfile extends ProfileEvent {
  final ProfileModel profile;

  UpdateProfile(this.profile);
}
class UpdatePhoneNumber extends ProfileEvent {
  final String phoneNumber;

  UpdatePhoneNumber(this.phoneNumber);
}
class UpdateEmailAddress extends ProfileEvent {
  final String emailAddress;

  UpdateEmailAddress(this.emailAddress);
}

class UpdatePassword extends ProfileEvent {
  final String currentPassword;
  final String newPassword;

  UpdatePassword({
    required this.currentPassword,
    required this.newPassword,
  });
}