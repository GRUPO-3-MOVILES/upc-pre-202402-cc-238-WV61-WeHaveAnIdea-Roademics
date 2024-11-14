class RegisRequest {
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String phoneNumber;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String biography;
  final String profileType;
  final String username;
  final String password;
  final List<String> roles;

  const RegisRequest({
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.phoneNumber,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.biography,
    required this.profileType,
    required this.username,
    required this.password,
    this.roles = const ['ROLE_USER'],
  });

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'phoneNumber': phoneNumber,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'biography': biography,
      'profileType': profileType,
      'username': username,
      'password': password,
      'roles': roles,
    };
  }
}

class PersonalInformationRequest {
  final AddressRequest address;
  final String phoneNumber;
  final PersonNameRequest personName;
  final DateTime dateOfBirth;
  final String fullName;

  const PersonalInformationRequest({
    required this.address,
    required this.phoneNumber,
    required this.personName,
    required this.dateOfBirth,
    required this.fullName,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address.toMap(),
      'phoneNumber': phoneNumber,
      'personName': personName.toMap(),
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'fullName': fullName,
    };
  }
}

class AddressRequest {
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String fullAddress;

  const AddressRequest({
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.fullAddress,
  });

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'fullAddress': fullAddress,
    };
  }
}

class PersonNameRequest {
  final String firstName;
  final String lastName;
  final String fullName;

  const PersonNameRequest({
    required this.firstName,
    required this.lastName,
    required this.fullName,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
    };
  }
}

class EmailRequest {
  final String address;

  const EmailRequest({required this.address});

  Map<String, dynamic> toMap() {
    return {
      'address': address,
    };
  }
}