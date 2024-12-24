part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> injectionContainer({
  bool isHiveEnable = true,
  String prefixBox = '',
}) async {
  if (isHiveEnable) {
    await _initHiveBoxes(prefixBox: prefixBox);
  }

  _metaDependancies();
  _dataSources();
  _repositories();
  _useCase();
  _cubit();
}

Future<void> _initHiveBoxes({
  String prefixBox = '',
}) async {
  await MainBoxStorage.initHive(prefixBox);
  sl.registerSingleton<MainBoxStorage>(MainBoxStorage());
}

void _metaDependancies() {
  sl.registerLazySingleton<DioClient>(() => DioClient(auth: sl()));
  sl.registerLazySingleton(() => AppRouter(authBloc: sl()));

  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
}

/// Register repositories
void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl(), sl()),
  );
  // sl.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(sl()));
}

/// Register dataSources
void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
}

void _useCase() {
  /// Auth
  sl.registerLazySingleton(() => CurrentUserCase(sl()));
  sl.registerLazySingleton(() => LoginCase(sl()));
  sl.registerLazySingleton(() => LogoutCase(sl()));
  sl.registerLazySingleton(() => RegisterCase(sl()));

  // /// Users
  sl.registerLazySingleton(() => MyprofileCase(sl()));
}

void _cubit() {
  /// Auth
  sl.registerLazySingleton(() => RegisterCubit(sl()));
  sl.registerLazySingleton(() => LoginCubit(sl()));
  sl.registerLazySingleton(() => AuthBloc(
        sl(),
        sl(),
      ));
}
