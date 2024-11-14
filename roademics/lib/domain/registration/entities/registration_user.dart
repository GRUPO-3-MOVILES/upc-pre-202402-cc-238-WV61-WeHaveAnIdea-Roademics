class RegistrationUser {
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

  const RegistrationUser({
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
}