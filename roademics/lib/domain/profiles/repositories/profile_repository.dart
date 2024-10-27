import 'package:roademics/domain/profiles/entities/profile_model.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile(ProfileModel profile);
  Future<ProfileModel> updatePhoneNumber(String phoneNumber);
  Future<ProfileModel> updateEmailAddress(String email);
  Future<bool> updatePassword(String currentPassword, String newPassword);
}