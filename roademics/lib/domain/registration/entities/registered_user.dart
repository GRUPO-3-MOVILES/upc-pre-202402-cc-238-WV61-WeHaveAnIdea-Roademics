class RegisteredUser {
  final String id;
  final String username;
  final List<String> roles;
  final String token;

  const RegisteredUser({
    required this.id,
    required this.username,
    required this.roles,
    required this.token,
  });
}
