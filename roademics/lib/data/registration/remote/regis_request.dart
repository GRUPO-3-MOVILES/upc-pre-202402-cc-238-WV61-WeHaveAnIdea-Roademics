class RegistrationRequest {
  final String username;
  final String password;
  final List<String> roles;

  const RegistrationRequest({
    required this.username,
    required this.password,
    this.roles = const ['ROLE_USER'],
  });

  Map<String, dynamic> toAuthMap() {
    return {
      'username': username,
      'password': password,
      'roles': roles,
    };
  }
}
