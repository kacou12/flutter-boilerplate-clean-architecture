import 'package:my/core/api/dio_client.dart';
import 'package:my/core/core.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/data/models/user_model.dart';
import 'package:my/features/auth/domain/entities/requests/request_auth.dart';

abstract class AuthRemoteDataSource {
  FutureResult<UserModel> login({required RequestLogin requests});

  FutureResult<UserModel> myProfile();
  FutureResult<UserModel> register({required RequestRegister requests});

  FutureResult<void> logout();
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
    final response = await dio.putRequest(
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
}
