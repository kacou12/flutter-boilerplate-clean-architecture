part of 'router.dart';

class AppRouter extends GoRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc})
    : super.routingConfig(
        onException: (_, GoRouterState state, GoRouter router) {
          router.go(PageRoutes.login.path);
        },
        refreshListenable: GoRouterRefreshStream(authBloc.stream),
        observers: <NavigatorObserver>[RouterObserver()],
        initialLocation: PageRoutes.splashScreen.path,
        navigatorKey: _rootNavigatorKey,
        routingConfig: ValueNotifier<RoutingConfig>(
          RoutingConfig(
            redirect: (context, state) async {
              final isLoggedIn = authBloc.state.isAuthenticated;

              if (!isLoggedIn) {
                if (state.matchedLocation == PageRoutes.onBoarding.path) {
                  return PageRoutes.onBoarding.path;
                } else if (state.matchedLocation == PageRoutes.login.path) {
                  return PageRoutes.login.path;
                } else if (state.matchedLocation ==
                    PageRoutes.splashScreen.path) {
                  return PageRoutes.splashScreen.path;
                } else if (state.matchedLocation == PageRoutes.register.path) {
                  return PageRoutes.register.path;
                } else {
                  return null;
                }
              }
              return null;
            },
            routes: [
              GoRoute(
                path: PageRoutes.login.path,
                name: PageRoutes.login.name,
                builder: (_, __) => const LoginScreen(),
              ),
              GoRoute(
                path: PageRoutes.register.path,
                name: PageRoutes.register.name,
                builder: (_, __) => BlocProvider(
                  create: (_) => sl<RegisterCubit>(),
                  child: const RegisterScreen(),
                ),
              ),
              // GoRoute(
              //   path: PageRoutes.forgotPassword.path,
              //   name: PageRoutes.forgotPassword.name,
              //   builder: (_, __) => BlocProvider(
              //     create: (_) => sl<ForgotPasswordBloc>(),
              //     lazy: false,
              //     child: const ForgotPasswordEmailScreen(),
              //   ),
              //   routes: [
              //     GoRoute(
              //       path: PageRoutes.forgotPasswordCode.path,
              //       name: PageRoutes.forgotPasswordCode.name,
              //       builder: (_, state) => ForgotPasswordCodeScreen(
              //         emailSentState: state.extra as ForgotPasswordEmailSent,
              //       ),
              //     ),
              //     GoRoute(
              //       path: PageRoutes.resetPassword.path,
              //       name: PageRoutes.resetPassword.name,
              //       builder: (_, __) => const ResetPasswordScreen(),
              //     ),
              //     GoRoute(
              //       path: PageRoutes.successResetPassword.path,
              //       name: PageRoutes.successResetPassword.name,
              //       builder: (_, __) => const PasswordSuccessScreen(),
              //     ),
              //   ],
              // ),
              ShellRoute(
                builder: (context, state, child) => BlocProvider(
                  create: (_) => sl<ForgotPasswordBloc>(),
                  lazy: false,
                  child: child, // L'enfant sera injecté ici
                ),
                routes: [
                  GoRoute(
                    path: PageRoutes.forgotPassword.path,
                    name: PageRoutes.forgotPassword.name,
                    builder: (_, __) => const ForgotPasswordEmailScreen(),
                  ),
                  GoRoute(
                    path: PageRoutes.forgotPasswordCode.path,
                    name: PageRoutes.forgotPasswordCode.name,
                    builder: (_, state) => ForgotPasswordCodeScreen(
                      emailSentState: state.extra as ForgotPasswordEmailSent,
                    ),
                  ),
                  GoRoute(
                    path: PageRoutes.resetPassword.path,
                    name: PageRoutes.resetPassword.name,
                    builder: (_, __) => const ResetPasswordScreen(),
                  ),
                  GoRoute(
                    path: PageRoutes.successResetPassword.path,
                    name: PageRoutes.successResetPassword.name,
                    builder: (_, __) => const PasswordSuccessScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: PageRoutes.onBoarding.path,
                name: PageRoutes.onBoarding.name,
                builder: (_, __) => const OnBoardingScreen(),
              ),
              GoRoute(
                path: PageRoutes.splashScreen.path,
                name: PageRoutes.splashScreen.name,
                redirect: (context, state) async {
                  final mainBoxStorage = sl<MainBoxStorage>();

                  if (mainBoxStorage.isFirstTime()) {
                    mainBoxStorage.cacheFirstTimer();
                    return PageRoutes.onBoarding.path;
                  }

                  return null;
                },
                builder: (context, state) => const SplashScreen(),
              ),
              StatefulShellRoute.indexedStack(
                builder: (context, state, child) => ScreenLayout(child: child),
                branches: [
                  StatefulShellBranch(
                    navigatorKey: _userNavigatorKey,
                    routes: [
                      GoRoute(
                        path: PageRoutes.userHome.path,
                        name: PageRoutes.userHome.name,
                        builder: (context, state) => const UsersScreen(),
                        routes: [
                          GoRoute(
                            parentNavigatorKey: _rootNavigatorKey,
                            path: PageRoutes.userProfil.path,
                            name: PageRoutes.userProfil.name,
                            builder: (context, state) =>
                                const UsersProfilScreen(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    navigatorKey: _chatNavigatorKey,
                    routes: [
                      GoRoute(
                        path: PageRoutes.chat.path,
                        name: PageRoutes.chat.name,
                        // parentNavigatorKey: _shellNavigatorKey,
                        builder: (context, state) => const ChatScreen(),
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    navigatorKey: _settingsNavigatorKey,
                    routes: [
                      GoRoute(
                        path: PageRoutes.settings.path,
                        name: PageRoutes.settings.name,
                        // parentNavigatorKey: _shellNavigatorKey,
                        builder: (context, state) => const SettingsScreen(),
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    navigatorKey: _productsNavigatorKey,
                    routes: [
                      GoRoute(
                        path: PageRoutes.products.path,
                        name: PageRoutes.products.name,
                        // parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) => const ProductsScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
