enum PageRoutes {
  root("/"),
  splashScreen("/splashscreen"),

  /// Home Page
  dashboard("/dashboard"),

  // auth Page
  login("/auth/login"),
  register("/auth/register"),

  forgotPassword("/auth/forgot-password"),
  forgotPasswordCode("/auth/forgot-password/verif-otp-by-email-or-tel"),
  resetPassword("/auth/forgot-password/reset-password"),
  successResetPassword("/auth/forgot-password/success-reset"),

  // profile Page
  userProfile("/profile"),
  userProfileEdit("/profile/edit"),

  onBoarding("/onBoarding"),

  // NAVIGATION BAR
  chat("/chat"),
  settings("/settings"),
  products("/products"),
  userHome("/user-home"),

  userProfil("/user-profil");

  const PageRoutes(this.path);

  final String path;
}
