import 'package:roademics/domain/authentication/entities/user.dart';

class UserDto {
  final String id;
  final String username;
  final String password;
  final String token;

  const UserDto({
    required this.id,
    required this.username,
    required this.password,
    required this.token,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['_id'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      token: json['token'] ?? '',
    );
  }

  User toUser() {
    return User(
      id: int.parse(id),
      username: username,
      password: password,
      token: token,
    );
  }
}
