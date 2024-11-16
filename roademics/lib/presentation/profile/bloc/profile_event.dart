abstract class ProfileEvent {
  const ProfileEvent();
}

class CreateProfile extends ProfileEvent {
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

  const CreateProfile({
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
    this.profileType = 'FREE_USER',
  });
}
