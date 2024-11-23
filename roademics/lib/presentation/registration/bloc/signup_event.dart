abstract class SignupEvent {
  const SignupEvent();
}

class SignupSubmitted extends SignupEvent {
  final String username;
  final String password;

  const SignupSubmitted({
    required this.username,
    required this.password,
  });
}
