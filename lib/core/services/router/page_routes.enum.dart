enum PageRoutes {
  root("/"),
  splashScreen("/splashscreen"),

  /// Home Page
  dashboard("/dashboard"),

  // auth Page
  login("/auth/login"),
  register("/auth/register"),
  verifOTPByEmailOrTel("/auth/verif_otp_by_email_or_tel"),

  forgotPasswordRoute("/forgot_password"),
  resetPasswordRoute("/reset_password"),

  // profile Page
  userProfile("/profile"),
  userProfileEdit("/profile/edit"),

  onBoarding("/onBoarding"),

  // NAVIGATION BAR
  chat("/chat"),
  settings("/settings"),
  products("/products"),
  userHome("/user_home"),

  userProfil("/user_profil");

  const PageRoutes(this.path);

  final String path;
}
