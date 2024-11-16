import 'package:roademics/domain/profile/entities/profile.dart';

class ProfileDto {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PersonalInformationDto personalInformation;
  final EmailDto email;
  final String profileType;
  final String biography;

  const ProfileDto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.personalInformation,
    required this.email,
    required this.profileType,
    required this.biography,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return ProfileDto(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      personalInformation:
          PersonalInformationDto.fromJson(json['personalInformation']),
      email: EmailDto.fromJson(json['email']),
      profileType: json['profileType'] ?? '',
      biography: json['biography'] ?? '',
    );
  }

  Profile toProfile() {
    return Profile(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      personalInformation: personalInformation.toPersonalInformation(),
      email: email.toEmail(),
      profileType: profileType,
      biography: biography,
    );
  }
}

class PersonalInformationDto {
  final AddressDto address;
  final String phoneNumber;
  final PersonNameDto personName;
  final DateTime dateOfBirth;
  final String fullName;

  const PersonalInformationDto({
    required this.address,
    required this.phoneNumber,
    required this.personName,
    required this.dateOfBirth,
    required this.fullName,
  });

  factory PersonalInformationDto.fromJson(Map<String, dynamic> json) {
    return PersonalInformationDto(
      address: AddressDto.fromJson(json['address']),
      phoneNumber: json['phoneNumber'] ?? '',
      personName: PersonNameDto.fromJson(json['personName']),
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      fullName: json['fullName'] ?? '',
    );
  }

  PersonalInformation toPersonalInformation() {
    return PersonalInformation(
      address: address.toAddress(),
      phoneNumber: phoneNumber,
      personName: personName.toPersonName(),
      dateOfBirth: dateOfBirth,
      fullName: fullName,
    );
  }
}

class AddressDto {
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String fullAddress;

  const AddressDto({
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.fullAddress,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) {
    return AddressDto(
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      zipCode: json['zipCode'] ?? '',
      fullAddress: json['fullAddress'] ?? '',
    );
  }

  Address toAddress() {
    return Address(
      city: city,
      state: state,
      country: country,
      zipCode: zipCode,
      fullAddress: fullAddress,
    );
  }
}

class PersonNameDto {
  final String firstName;
  final String lastName;
  final String fullName;

  const PersonNameDto({
    required this.firstName,
    required this.lastName,
    required this.fullName,
  });

  factory PersonNameDto.fromJson(Map<String, dynamic> json) {
    return PersonNameDto(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '',
    );
  }

  PersonName toPersonName() {
    return PersonName(
      firstName: firstName,
      lastName: lastName,
      fullName: fullName,
    );
  }
}

class EmailDto {
  final String address;

  const EmailDto({required this.address});

  factory EmailDto.fromJson(Map<String, dynamic> json) {
    return EmailDto(
      address: json['address'] ?? '',
    );
  }

  Email toEmail() {
    return Email(address: address);
  }
}
