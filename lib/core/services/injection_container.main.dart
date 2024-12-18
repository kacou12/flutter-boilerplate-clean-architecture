part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> injectionContainer({
  bool isHiveEnable = true,
  String prefixBox = '',
}) async {
  if (isHiveEnable) {
    await _initHiveBoxes(prefixBox: prefixBox);
  }
  sl.registerSingleton<DioClient>(DioClient(auth: sl()));
  sl.registerLazySingleton(() => AppRouter(authBloc: sl()));
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
  // sl.registerLazySingleton<UsersRemoteDatasource>(
  //   () => UsersRemoteDatasourceImpl(sl()),
  // );
}

void _useCase() {
  /// Auth
  sl.registerLazySingleton(() => CurrentUserCase(sl()));
  sl.registerLazySingleton(() => LoginCase(sl()));
  sl.registerLazySingleton(() => LogoutCase(sl()));
  sl.registerLazySingleton(() => RegisterCase(sl()));
  // sl.registerLazySingleton(() => PostRegister(sl()));
  // sl.registerLazySingleton(() => PostGeneralToken(sl()));

  // /// Users
  sl.registerLazySingleton(() => MyprofileCase(sl()));
}

void _cubit() {
  /// Auth
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()));
}
