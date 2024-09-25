class CreateUserRequest {
  String fullName;
  String email;
  String password;
  String confirmPassword;

  CreateUserRequest({required this.fullName, required this.email, required this.password, required this.confirmPassword});
}
