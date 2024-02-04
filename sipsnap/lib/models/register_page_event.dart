class RegisterPageEvent {
  final String id;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterPageEvent({ required this.id, required this.email, required this.password, required this.confirmPassword});
}