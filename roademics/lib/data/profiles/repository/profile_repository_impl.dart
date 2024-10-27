import 'package:roademics/domain/profiles/entities/profile_model.dart';
import 'package:roademics/domain/profiles/repositories/profile_repository.dart';
import 'package:roademics/data/profiles/remote/profile_service.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileService _service;

  ProfileRepositoryImpl(this._service);

  @override
  Future<ProfileModel> getProfile() async {
    return await _service.getProfile();
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    return await _service.updateProfile(profile);
  }

  @override
  Future<ProfileModel> updatePhoneNumber(String phoneNumber) async {
    final profile = await _service.getProfile();
    final updatedProfile = profile.copyWith(
      personalInformation: profile.personalInformation.copyWith(
        phoneNumber: phoneNumber,
      ),
    );
    return await _service.updateProfile(updatedProfile);
  }

  @override
  Future<ProfileModel> updateEmailAddress(String email) async {
    final profile = await _service.getProfile();
    final updatedProfile = profile.copyWith(
      email: email,
    );
    return await _service.updateProfile(updatedProfile);
  }

  @override
  Future<bool> updatePassword(String currentPassword, String newPassword) async {
    return await _service.updatePassword(currentPassword, newPassword);
  }

  @override
  Future<bool> deleteAccount(String password) async {
    return await _service.deleteAccount(password);
  }
}