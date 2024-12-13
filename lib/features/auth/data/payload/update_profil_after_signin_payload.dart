class UpdateProfilAfterSigninPayload {
  final String userName;

  UpdateProfilAfterSigninPayload({
    required this.userName,
  });

  factory UpdateProfilAfterSigninPayload.fromJson(Map<String, dynamic> json) {
    return UpdateProfilAfterSigninPayload(
      userName: json['user_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': userName,
    };
  }
}