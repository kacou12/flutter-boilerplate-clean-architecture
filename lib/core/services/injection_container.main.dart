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
  _cubit();
}

Future<void> _initHiveBoxes({String prefixBox = ''}) async {
  await MainBoxStorage.initialize(prefixBox);

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

/// Register dataSources
void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
}

/// Register repositories
void _repositories() {
  sl.registerLazySingleton(() => AuthRepositoryImpl(sl(), sl(), sl()));
  sl.registerLazySingleton(
    () => ForgotPasswordRepositoryImpl(sl(), sl(), sl()),
  );
}

void _cubit() {
  /// Auth
  sl.registerLazySingleton(() => RegisterCubit(sl()));
  sl.registerLazySingleton(() => LoginCubit(sl()));
  sl.registerLazySingleton(() => AuthBloc(sl()));
  sl.registerLazySingleton(() => ForgotPasswordBloc(repository: sl()));
}
