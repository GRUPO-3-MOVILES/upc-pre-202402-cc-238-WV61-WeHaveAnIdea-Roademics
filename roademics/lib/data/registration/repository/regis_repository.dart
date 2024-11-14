import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/profiles/remote/profile_dto.dart';
import 'package:roademics/data/registration/remote/regis_request.dart';
import 'package:roademics/data/registration/remote/regis_service.dart';
import 'package:roademics/domain/profiles/entities/profile.dart';

class RegisRepository {
  final RegisService _regisService = RegisService();

  Future<GenericResource<Profile>> register(RegisRequest request) async {
    GenericResource<ProfileDto> result = await _regisService.register(request);

    if (result is Success) {
      return Success(result.data!.toProfile());
    } else {
      return Error(result.message!);
    }
  }

  Future<GenericResource<Profile>> createProfile(RegisRequest request) async {
    GenericResource<ProfileDto> result = await _regisService.createProfile(request);

    if (result is Success) {
      return Success(result.data!.toProfile());
    } else {
      return Error(result.message!);
    }
  }

  Future<GenericResource<Profile>> updateProfile(String id, RegisRequest request) async {
    GenericResource<ProfileDto> result = await _regisService.updateProfile(id, request);

    if (result is Success) {
      return Success(result.data!.toProfile());
    } else {
      return Error(result.message!);
    }
  }

  Future<GenericResource<Profile>> getProfileById(String id) async {
    GenericResource<ProfileDto> result = await _regisService.getProfileById(id);

    if (result is Success) {
      return Success(result.data!.toProfile());
    } else {
      return Error(result.message!);
    }
  }

  Future<GenericResource<List<Profile>>> getAllProfiles() async {
    GenericResource<List<ProfileDto>> result = await _regisService.getAllProfiles();

    if (result is Success) {
      List<Profile> profiles = result.data!.map((dto) => dto.toProfile()).toList();
      return Success(profiles);
    } else {
      return Error(result.message!);
    }
  }
}