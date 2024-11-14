class AuthUser {
  final String id;
  final String username;
  final String password;
  final String token;

  const AuthUser({
    required this.id,
    required this.username,
    required this.password,
    required this.token,
  });
}
