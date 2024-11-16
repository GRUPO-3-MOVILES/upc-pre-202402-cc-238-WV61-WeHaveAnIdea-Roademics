class ProfileRequest {
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

  const ProfileRequest({
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
  });

  Map<String, dynamic> toProfileMap() {
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
    };
  }
}
