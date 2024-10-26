class ProfileModel {
  String id;
  PersonalInformation personalInformation;
  String email;
  String profileType;
  String biography;
  String fullName;

  ProfileModel({
    required this.id,
    required this.personalInformation,
    required this.email,
    required this.profileType,
    required this.biography,
    required this.fullName,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      personalInformation: PersonalInformation.fromJson(json['personalInformation'] ?? {}),
      email: json['email']['address'] ?? '',
      profileType: json['profileType'] ?? '',
      biography: json['biography'] ?? '',
      fullName: json['fullName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'personalInformation': personalInformation.toJson(),
      'email': email,
      'profileType': profileType,
      'biography': biography,
      'fullName': fullName,
    };
  }
}

class PersonalInformation {
  Address address;
  String phoneNumber;
  PersonName personName;
  DateTime dateOfBirth;

  PersonalInformation({
    required this.address,
    required this.phoneNumber,
    required this.personName,
    required this.dateOfBirth,
  });

  factory PersonalInformation.fromJson(Map<String, dynamic> json) {
    return PersonalInformation(
      address: Address.fromJson(json['address'] ?? {}),
      phoneNumber: json['phoneNumber'] ?? '',
      personName: PersonName.fromJson(json['personName'] ?? {}),
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      'phoneNumber': phoneNumber,
      'personName': personName.toJson(),
      'dateOfBirth': dateOfBirth.toIso8601String(),
    };
  }
}

class Address {
  String city;
  String state;
  String country;
  String zipCode;
  String fullAddress;

  Address({
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.fullAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      zipCode: json['zipCode'] ?? '',
      fullAddress: json['fullAddress'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'fullAddress': fullAddress,
    };
  }
}

class PersonName {
  String firstName;
  String lastName;
  String fullName;

  PersonName({
    required this.firstName,
    required this.lastName,
    required this.fullName,
  });

  factory PersonName.fromJson(Map<String, dynamic> json) {
    return PersonName(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
    };
  }
}