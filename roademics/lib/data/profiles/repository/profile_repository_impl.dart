import 'package:roademics/domain/profiles/entities/profile_model.dart';
import 'package:roademics/data/profiles/repository/profile_repository.dart';
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
}