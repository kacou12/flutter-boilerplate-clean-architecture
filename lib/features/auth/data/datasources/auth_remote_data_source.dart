import 'package:dartz/dartz.dart';
import 'package:my/core/api/dio_client.dart';
import 'package:my/core/core.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/data/models/user_model.dart';
import 'package:my/features/auth/data/payload/requests/request_auth.dart';

abstract class AuthRemoteDataSource {
  FutureResult<UserModel> login({required RequestLogin requests});

  FutureResult<UserModel> myProfile();
  FutureResult<UserModel> register({required RequestRegister requests});
  FutureResult<void> logout();

  FutureResult<Map<String, String>> sendPasswordReset(String email);
  FutureResult<bool> verifyResetCode(String code);
  FutureResult<bool> resetPassword(String newPassword, String confirmPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  FutureResult<UserModel> login({required RequestLogin requests}) async {
    final response = await dio.postRequest(
      ListAPI.login,
      data: requests.toJson(),
      converter: (response) =>
          UserModel.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }

  @override
  FutureResult<UserModel> myProfile() async {
    final response = await dio.getRequest(
      ListAPI.myProfile,
      converter: (response) =>
          UserModel.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }

  @override
  FutureResult<void> logout() async {
    final response = await dio.postRequest(
      ListAPI.logout,
      data: {"device_id": "71215494-78AD-4173-834F-9724447D71FA"},
      converter: (response) => EmptyResponse.fromJson(response),
    );
    return response;
  }

  @override
  FutureResult<UserModel> register({required RequestRegister requests}) async {
    final response = await dio.postRequest(
      ListAPI.register,
      data: requests.toJson(),
      converter: (response) =>
          UserModel.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }

  @override
  FutureResult<Map<String, String>> sendPasswordReset(String email) async {
    // final response = await dio.postRequest(
    //   ListAPI.forgotPassword,
    //   data: {'email': email},
    //   converter: (response) => response as Map<String, String>,
    // );
    // return response;

    try {
      return Future.delayed(
        Duration(seconds: 2),
      ).then((value) => Right({'email': email}));
    } catch (e) {
      return Left(
        ServerFailure(
          message: "Error Occurred: It's not your fault, it's ours",
          statusCode: 500,
        ),
      );
    }
  }

  @override
  FutureResult<bool> verifyResetCode(String code) async {
    // final response = await dio.postRequest(
    //   ListAPI.verifyResetCode,
    //   data: {'code': code},
    //   converter: (response) => response as bool,
    // );
    // return response;

    try {
      return Future.delayed(Duration(seconds: 2)).then((value) => Right(true));
    } catch (e) {
      return Left(
        ServerFailure(
          message: "Error Occurred: It's not your fault, it's ours",
          statusCode: 500,
        ),
      );
    }
  }

  @override
  FutureResult<bool> resetPassword(
    String newPassword,
    String confirmPassword,
  ) async {
    // final response = await dio.postRequest(
    //   ListAPI.resetPassword,
    //   data: {'newPassword': newPassword, 'confirmPassword': confirmPassword},
    //   converter: (response) => response as bool,
    // );
    // return response;

    try {
      return Future.delayed(Duration(seconds: 2)).then((value) => Right(true));
    } catch (e) {
      return Left(
        ServerFailure(
          message: "Error Occurred: It's not your fault, it's ours",
          statusCode: 500,
        ),
      );
    }
  }
}
