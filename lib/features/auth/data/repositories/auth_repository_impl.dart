import 'package:dartz/dartz.dart';
import 'package:my/core/errors/failures.dart';
import 'package:my/core/network/network_info.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:my/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:my/features/auth/domain/entities/requests/request_auth.dart';
import 'package:my/features/auth/domain/entities/user.dart';
import 'package:my/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final AuthLocalDataSource store;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.store,
  });

  @override
  FutureResult<User> login(RequestParamsLogin params) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.login(
          requests:
              RequestLogin(userName: params.email, password: params.password));

      return response.fold(
        (failure) => Left(failure),
        (response) async {
          await store.saveData(response);
          return Right(response);
        },
      );
    } else {
      return const Left(CacheFailure());
    }
  }

  @override
  FutureEitherResult<User> myProfile() async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.myProfile();

      return response.fold(
        (failure) => Left(failure),
        (response) async {
          await store.saveData(response);
          return Right(response);
        },
      );
    } else {
      return const Left(CacheFailure());
    }
  }

  @override
  FutureResult<User> get currentUser async {
    try {
      final user = await store.loadData();

      if (user == null) {
        return const Right(null);
      }
      return Right(user);
    } catch (e) {
      return const Left(CacheFailure(
          message: "Connexion implicite à echouer, veuillez vous connectez."));
    }
  }

  @override
  FutureEitherResult<void> loggout() async {
    final response = await remoteDataSource.logout();
    return response.fold(
      (failure) => Left(failure),
      (response) async {
        return Right(await store.deleteData());
      },
    );
  }

  @override
  FutureEitherResult<User> register(RequestParamsRegister request) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.register(
            requests: RequestRegister(
                name: request.name,
                user_name: request.user_name,
                email: request.email,
                password: request.password,
                interests_id: request.interests_id,
                sponsor: request.sponsor,
                country: request.country,
                city: request.city,
                phone: request.phone,
                device_id: request.device_id,
                device_type: request.device_type));

        if (response is Success<UserModel>) {
          await store.saveData(response.data);
          return Right(response.data);
        } else {
          final errorMessage =
              response.asOrNull<Failed<dynamic>>()?.errors.error ??
                  'Erreur inconnue';
          return Left(ServerFailure(message: errorMessage));
        }
      } catch (e) {
        return Left(ServerFailure(message: "$e"));
      }
    } else {
      return const Left(ServerFailure(
          message: "Veuillez verifier votre connection internet"));
    }
  }
}