part of 'router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter extends GoRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc})
      : super.routingConfig(
          onException: (_, GoRouterState state, GoRouter router) {
            router.go(PageRoutes.login.path);
          },
          refreshListenable: GoRouterRefreshStream(authBloc.stream),
          observers: <NavigatorObserver>[
            RouterObserver(),
          ],
          initialLocation: PageRoutes.splashScreen.path,
          routingConfig: ValueNotifier<RoutingConfig>(
            RoutingConfig(
                redirect: (context, state) async {
                  final isLoggedIn = authBloc.state.isAuthenticated;

                  if (!isLoggedIn) {
                    if (state.matchedLocation ==
                        PageRoutes.onBordingRoute.path) {
                      return PageRoutes.onBordingRoute.path;
                    } else if (state.matchedLocation == PageRoutes.login.path) {
                      return PageRoutes.login.path;
                    } else if (state.matchedLocation ==
                        PageRoutes.register.path) {
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
                    builder: (_, __) => BlocProvider(
                      create: (_) => sl<LoginCubit>(),
                      child: const LoginScreen(),
                    ),
                  ),
                  GoRoute(
                    path: PageRoutes.register.path,
                    name: PageRoutes.register.name,
                    builder: (_, __) => BlocProvider(
                      create: (_) => sl<RegisterCubit>(),
                      child: const RegisterScreen(),
                    ),
                  ),
                  GoRoute(
                    path: PageRoutes.userHome.path,
                    name: PageRoutes.userHome.name,
                    builder: (_, __) => const UsersScreen(),
                  ),
                  GoRoute(
                    name: PageRoutes.splashScreen.path,
                    path: PageRoutes.splashScreen.path,
                    redirect: (context, state) async {
                      final mainBoxStorage = sl<MainBoxStorage>();
                      if (authBloc.state.isAuthenticated) {
                        return PageRoutes.userHome.name;
                      }
                      // TODO : check this  only if used onboarding
                      else if (authBloc.state.isUnauthenticated &&
                          mainBoxStorage.isFirstTime()) {
                        return PageRoutes.onBordingRoute.name;
                      }

                      return null;
                    },
                    builder: (context, state) => const SplashScreen(),
                  ),
                ]),
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
