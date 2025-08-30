import 'package:dartz/dartz.dart';
import 'package:my/core/errors/failures.dart';
import 'package:my/core/network/network_info.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:my/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:my/features/auth/data/repositories/auth/forgot_password_repository.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final AuthLocalDataSource store;

  ForgotPasswordRepositoryImpl(
    this.remoteDataSource,
    this.networkInfo,
    this.store,
  );

  @override
  FutureResult<Map<String, String>> sendPasswordReset(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.sendPasswordReset(email);

        return response.fold((failure) => Left(failure), (response) async {
          return Right(response);
        });
      } catch (e) {
        return Left(CacheFailure(message: "$e"));
      }
    } else {
      return const Left(
        CacheFailure(message: "Veuillez verifier votre connection internet"),
      );
    }
  }

  @override
  FutureResult<bool> resetPassword(
    String newPassword,
    String confirmPassword,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.resetPassword(
          newPassword,
          confirmPassword,
        );

        return response.fold((failure) => Left(failure), (response) async {
          return Right(response);
        });
      } catch (e) {
        return Left(CacheFailure(message: "$e"));
      }
    } else {
      return const Left(
        CacheFailure(message: "Veuillez verifier votre connection internet"),
      );
    }
  }

  @override
  FutureResult<bool> verifyResetCode(String code) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.verifyResetCode(code);

        return response.fold((failure) => Left(failure), (response) async {
          return Right(response);
        });
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
