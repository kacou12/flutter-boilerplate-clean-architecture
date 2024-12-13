enum AppRoute {
  root("/"),
  splashScreen("/splashscreen"),

  /// Home Page
  dashboard("/dashboard"),
  settings("/settings"),

  // auth Page
  login("/auth/login"),
  register("/auth/register"),
  verifOTPByEmailOrTel("/auth/verif_otp_by_email_or_tel"),
  signInRoute("/sign_in"),
  signUpRoute("/sign_up"),
  signUpOtpStep("/sign_up_otp_step"),
  signUpSecondStep("/sign_up_second_step"),
  forgotPasswordRoute("/forgot_password"),
  resetPasswordRoute("/reset_password"),

  onBordingRoute("/onBordingRoute");

  const AppRoute(this.path);

  final String path;
}
