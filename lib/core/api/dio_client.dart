import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my/core/api/api_result.dart';
import 'package:my/core/core.dart';
import 'package:my/core/utils/constants/network_constants.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:my/features/auth/data/models/user_model.dart';

class DioClient {
  final AuthLocalDataSource auth;

  final Dio _dio;

  DioClient._internal(this._dio, this.auth);

  static DioClient? _instance;

  factory DioClient({required AuthLocalDataSource auth}) {
    if (_instance == null) {
      final dio = Dio(BaseOptions(
        baseUrl: NetworkConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: 8000),
        receiveTimeout: const Duration(milliseconds: 8000),
        headers: NetworkConstants.headers,
      ));

      dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ));

      _instance = DioClient._internal(dio, auth);
    }
    _instance!._addAuthInterceptor();
    return _instance!;
  }

  void _addAuthInterceptor() async {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final UserModel? currentUser;
        currentUser = await auth.loadData();
        if (currentUser?.token != null) {
          options.headers['Authorization'] = 'Bearer ${currentUser?.token}';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          try {
            final UserModel? currentUser = await auth.loadData();
            if (currentUser?.refreshToken == null) {
              return handler.next(error);
            }

            final response = await _dio.post(
              ListAPI.refresh,
              data: {
                'refresh_token': currentUser!.refreshToken,
              },
            );

            if (response.statusCode == 200) {
              final newToken = response.data['token'];
              final newRefreshToken = response.data['refresh_token'];

              final userUpdating = currentUser.copyWith(
                token: newToken,
                refreshToken: newRefreshToken,
              );

              await auth.saveData(userUpdating);

              final opts = error.requestOptions;
              opts.headers['Authorization'] = 'Bearer $newToken';

              final newResponse = await _dio.fetch(opts);
              return handler.resolve(newResponse);
            }
          } catch (e) {
            await auth.deleteData();

            return handler.next(error);
          }
        }
        return handler.next(error);
      },
    ));
  }

  FutureResult<T> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw ServerException(
          message: response.statusMessage ?? 'Unknown Error',
          statusCode: response.statusCode ?? 500,
        );
      }

      return Right(
          ApiResult.fromResponse(mapper: converter, response: response));
    } on ServerException catch (e) {
      try {
        return Left(
          ServerFailure.fromException(e),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: s);
        // throw const
        return const Left(ServerFailure(
          message: "Error Occurred: It's not your fault, it's ours",
          statusCode: 500,
        ));
      }
    }
  }

  FutureResult<T> postRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw ServerException(
          message: response.statusMessage ?? 'Unknown Error',
          statusCode: response.statusCode ?? 500,
        );
      }

      return Right(
        ApiResult.fromResponse(mapper: converter, response: response),
      );
    } on DioException catch (error) {
      final exception = RequestException.fromDioError(error);
      return Left(ServerFailure(
          message: exception.message, statusCode: exception.statusCode ?? 400));
    }
    // on ServerException
    catch (e) {
      return const Left(ServerFailure(
        message: "Erro  r Occurred: It's not your fault, it's ours",
        statusCode: 500,
      ));
    }
  }

  FutureResult<T> putRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw ServerException(
          message: response.statusMessage ?? 'Unknown Error',
          statusCode: response.statusCode ?? 500,
        );
      }

      return Right(
        ApiResult.fromResponse(mapper: converter, response: response),
      );
    } on DioException catch (error) {
      final exception = RequestException.fromDioError(error);
      return Left(ServerFailure(
          message: exception.message, statusCode: exception.statusCode ?? 400));
    }
    // on ServerException
    catch (e) {
      return const Left(ServerFailure(
        message: "Erro  r Occurred: It's not your fault, it's ours",
        statusCode: 500,
      ));
    }
  }
}
