import 'package:dartz/dartz.dart';
import 'package:my/core/errors/failures.dart';
import 'package:my/core/network/network_info.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:my/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:my/features/auth/data/models/user_model.dart';
import 'package:my/features/auth/data/payload/requests/request_auth.dart';
import 'package:my/features/auth/data/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final AuthLocalDataSource store;

  AuthRepositoryImpl(this.remoteDataSource, this.networkInfo, this.store);

  @override
  FutureResult<UserModel> login(RequestParamsLogin params) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.login(
        requests: RequestLogin(email: params.email, password: params.password),
      );

      return response.fold((failure) => Left(failure), (response) async {
        await store.saveData(response);
        return Right(response);
      });
    } else {
      return const Left(CacheFailure());
    }
  }

  @override
  FutureResult<UserModel> myProfile() async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.myProfile();

      return response.fold((failure) => Left(failure), (response) async {
        await store.saveData(response);
        return Right(response);
      });
    } else {
      return const Left(CacheFailure());
    }
  }

  @override
  FutureResult<UserModel?> get currentUser async {
    try {
      // await store.deleteData();
      final user = await store.loadData();

      if (user == null) {
        return const Right(null);
      }
      return Right(user);
    } catch (e) {
      return const Left(
        CacheFailure(
          message: "Connexion implicite à echouer, veuillez vous connectez.",
        ),
      );
    }
  }

  @override
  FutureResult<void> loggout() async {
    final response = await remoteDataSource.logout();
    return response.fold((failure) => Left(failure), (response) async {
      return Right(await store.deleteData());
    });
  }

  @override
  FutureResult<UserModel> register(RequestParamsRegister request) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.register(
          requests: RequestRegister(
            firstName: request.firstName,
            lastName: request.lastName,
            email: request.email,
            password: request.password,
            phone: request.phone,
          ),
        );

        return response.fold((failure) => Left(failure), (response) async {
          await store.saveData(response);
          return Right(response);
        });

        // if (response is Success<UserModel>) {
        //   await store.saveData(response.data);
        //   return Right(response.data);
        // } else {
        //   final errorMessage =
        //       response.asOrNull<Failed<dynamic>>()?.errors.error ??
        //           'Erreur inconnue';
        //   return Left(ServerFailure(message: errorMessage));
        // }
      } catch (e) {
        return Left(CacheFailure(message: "$e"));
      }
    } else {
      return const Left(
        CacheFailure(message: "Veuillez verifier votre connection internet"),
      );
    }
  }
}
