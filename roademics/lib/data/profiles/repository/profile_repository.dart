import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/profiles/remote/profile_service.dart';
import 'package:roademics/data/profiles/remote/profile_dto.dart';
import 'package:roademics/domain/profiles/entities/profile.dart';

class ProfileRepository {
  Future<GenericResource<Profile>> getProfileById(String id) async {
    GenericResource<ProfileDto> result = await ProfileService().getProfileById(id: id);

    if (result is Success) {
      return Success(result.data!.toProfile());
    } else {
      return Error(result.message!);
    }
  }

  Future<GenericResource<List<Profile>>> getAllProfiles() async {
    GenericResource<List<ProfileDto>> result = await ProfileService().getAllProfiles();

    if (result is Success) {
      List<Profile> profiles = result.data!.map((dto) => dto.toProfile()).toList();
      return Success(profiles);
    } else {
      return Error(result.message!);
    }
  }

  Future<GenericResource<Profile>> createProfile({
    required String city,
    required String state,
    required String country,
    required String zipCode,
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String biography,
    required String profileType,
  }) async {
    GenericResource<ProfileDto> result = await ProfileService().createProfile(
      city: city,
      state: state,
      country: country,
      zipCode: zipCode,
      phoneNumber: phoneNumber,
      email: email,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      biography: biography,
      profileType: profileType,
    );

    if (result is Success) {
      return Success(result.data!.toProfile());
    } else {
      return Error(result.message!);
    }
  }

  Future<GenericResource<Profile>> updateProfile({
    required String id,
    required String city,
    required String state,
    required String country,
    required String zipCode,
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String biography,
    required String profileType,
  }) async {
    GenericResource<ProfileDto> result = await ProfileService().updateProfile(
      id: id,
      city: city,
      state: state,
      country: country,
      zipCode: zipCode,
      phoneNumber: phoneNumber,
      email: email,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      biography: biography,
      profileType: profileType,
    );

    if (result is Success) {
      return Success(result.data!.toProfile());
    } else {
      return Error(result.message!);
    }
  }
}