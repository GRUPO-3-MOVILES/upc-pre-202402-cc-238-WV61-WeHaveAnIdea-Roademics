import 'package:roademics/domain/profile/entities/profile.dart';

class ProfileDto {
  final String id;
  final String firstName;
  final String lastName;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String email;
  final String profileType;
  final String biography;

  ProfileDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.email,
    required this.profileType,
    required this.biography,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return ProfileDto(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      zipCode: json['zipCode'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      dateOfBirth: DateTime.parse(json['dateOfBirth'] ?? ''),
      email: json['email'] ?? '',
      profileType: json['profileType'] ?? '',
      biography: json['biography'] ?? '',
    );
  }

  Profile toProfile() {
    return Profile(
      id: id,
      personalInformation: PersonalInformation(
        address: Address(
          city: city,
          state: state,
          country: country,
          zipCode: zipCode,
          fullAddress: '$city, $state, $country, $zipCode',
        ),
        phoneNumber: phoneNumber,
        personName: PersonName(
          firstName: firstName,
          lastName: lastName,
          fullName: '$firstName $lastName',
        ),
        dateOfBirth: dateOfBirth,
        fullName: '$firstName $lastName',
      ),
      email: Email(address: email),
      profileType: profileType,
      biography: biography,
    );
  }
}
