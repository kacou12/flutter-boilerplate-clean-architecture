abstract class ListAPI {
  /// Auth
  static const String generalToken = "/auth/general";
  static const String user = "/user";
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String myProfile = "/auth/profile";
  static const String logout = "/auth/logout";
  static const String refresh = "/auth/refresh";
  static const String forgotPassword = "auth/forgot-password";
  static const String verifyResetCode = "auth/verify-reset-code";
  static const String resetPassword = "auth/reset-password";

  /// User
  static const String users = "/user/all";
}
