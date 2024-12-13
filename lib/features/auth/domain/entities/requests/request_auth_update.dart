class RequestUpdatePassword {
  final String oldPassword;
  final String password;

  RequestUpdatePassword({
    required this.oldPassword,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'old_password': oldPassword,
      'password': password,
    };
  }
}
