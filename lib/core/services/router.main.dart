part of 'router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: AppRoute.root.path,
  routes: [
    // GoRoute(
    //   path: Routes.verifOTPByEmailOrTel.path,
    //   pageBuilder: (context, state) => NoTransitionPage(
    //       child: VerifyAccountWithOtpPage(
    //     account: state.extra! as RequestParamsForgotPassword,
    //   )),
    // ),
    // GoRoute(
    //   path: Routes.onBordingRoute.path,
    //   redirect: (context, state) {
    //     if (appBloc.state.status == AppStatus.authenticated) {
    //       return Routes.feedRoute;
    //     }
    //     return null;
    //   },
    //   pageBuilder: (context, state) =>
    //       const NoTransitionPage(child: AuthPage()),
    // ),
    // GoRoute(
    //   path: Routes.signInRoute.path,
    //   pageBuilder: (context, state) => const NoTransitionPage(child: SignIn()),
    // ),
    // GoRoute(
    //     path: Routes.signUpRoute.path,
    //     pageBuilder: (context, state) =>
    //         const NoTransitionPage(child: RegisterPage()),
    //     routes: [
    //       GoRoute(
    //           path: Routes.signUpOtpStep.path,
    //           name: Routes.signUpOtpStep.path,
    //           pageBuilder: (context, state) => NoTransitionPage(
    //                 child: SignUpOtpStep(
    //                   continueOnEditInteretPage: (state.extra as Map<String,
    //                           dynamic>)['continueOnEditInteretPage'] ??
    //                       '',
    //                   continueValue:
    //                       (state.extra as Map<String, dynamic>)['continue'] ??
    //                           '',
    //                   email:
    //                       (state.extra as Map<String, dynamic>)['email'] ?? '',
    //                 ),
    //               ))
    //     ]),
    // GoRoute(
    //   path: Routes.signUpSecondStep.path,
    //   pageBuilder: (context, state) => NoTransitionPage(
    //       child: SignUpSecondStep(
    //     onNext: () {},
    //   )),
    // ),
    // GoRoute(
    //   path: Routes.forgotPasswordRoute.path,
    //   pageBuilder: (context, state) =>
    //       const NoTransitionPage(child: ForgotPasswordPage()),
    // ),
    // GoRoute(
    //   path: Routes.verifOTPByEmailOrTel.path,
    //   pageBuilder: (context, state) => NoTransitionPage(
    //       child: VerifyAccountWithOtpPage(
    //     account: state.extra! as RequestParamsForgotPassword,
    //   )),
    // ),
    // GoRoute(
    //   path: Routes.resetPasswordRoute.path,
    //   pageBuilder: (context, state) => NoTransitionPage(
    //       child: RestorePasswordPage(
    //     account: state.extra! as RequestParamsResetPasswordWithToken,
    //   )),
    // ),
    // GoRoute(
    //     path: '/',
    //     redirect: (context, state) {
    //       final cacheHelper = sl<CacheHelper>()
    //         ..getSessionToken()
    //         ..getUserId();
    //       if ((Cache.instance.sessionToken == null ||
    //               Cache.instance.userId == null) &&
    //           !cacheHelper.isFirstTime()) {
    //         return LoginScreen.path;
    //       }
    //       if (state.extra == 'home') return HomeView.path;

    //       return null;
    //     },
    //     builder: (_, __) {
    //       final cacheHelper = sl<CacheHelper>()
    //         ..getSessionToken()
    //         ..getUserId();
    //       if (cacheHelper.isFirstTime()) {
    //         return const OnBoardingScreen();
    //       }
    //       return const SplashScreen();
    //     }),
    // GoRoute(path: LoginScreen.path, builder: (_, __) => const LoginScreen()),
    // ShellRoute(
    //   builder: (context, state, child) {
    //     return DashboardScreen(state: state, child: child);
    //   },
    //   routes: [
    //     GoRoute(
    //       path: HomeView.path,
    //       builder: (_, __) => const HomeView(),
    //     ),
    //   ],
    // ),
  ],
);
