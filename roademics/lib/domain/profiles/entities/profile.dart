class Profile {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PersonalInformation personalInformation;
  final Email email;
  final String profileType;
  final String biography;

  const Profile({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.personalInformation,
    required this.email,
    required this.profileType,
    required this.biography,
  });
}

class PersonalInformation {
  final Address address;
  final String phoneNumber;
  final PersonName personName;
  final DateTime dateOfBirth;
  final String fullName;

  const PersonalInformation({
    required this.address,
    required this.phoneNumber,
    required this.personName,
    required this.dateOfBirth,
    required this.fullName,
  });
}

class Address {
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String fullAddress;

  const Address({
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.fullAddress,
  });
}

class PersonName {
  final String firstName;
  final String lastName;
  final String fullName;

  const PersonName({
    required this.firstName,
    required this.lastName,
    required this.fullName,
  });
}

class Email {
  final String address;

  const Email({required this.address});
}