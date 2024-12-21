enum PageRoutes {
  root("/"),
  splashScreen("/splashscreen"),

  /// Home Page
  dashboard("/dashboard"),
  settings("/settings"),

  // auth Page
  login("/auth/login"),
  register("/auth/register"),
  verifOTPByEmailOrTel("/auth/verif_otp_by_email_or_tel"),

  forgotPasswordRoute("/forgot_password"),
  resetPasswordRoute("/reset_password"),

  // profile Page
  userProfile("/profile"),
  userProfileEdit("/profile/edit"),
  userHome("/profile/home"),

  onBoarding("/onBoarding");

  const PageRoutes(this.path);

  final String path;
}
