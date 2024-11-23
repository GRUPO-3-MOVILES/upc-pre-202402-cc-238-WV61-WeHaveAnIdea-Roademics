import 'package:roademics/domain/registration/entities/registered_user.dart';

class RegistrationDto {
  final String id;
  final String username;
  final List<String> roles;
  final String token; // Agregado: el token JWT

  RegistrationDto({
    required this.id,
    required this.username,
    required this.roles,
    required this.token,
  });

  factory RegistrationDto.fromJson(Map<String, dynamic> json) {
    return RegistrationDto(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
      token: json['token'] ?? '', // Asegúrate de que el token venga del backend
    );
  }

  RegisteredUser toRegisteredUser() {
    return RegisteredUser(
      id: id,
      username: username,
      roles: roles,
      token: token,
    );
  }
}
