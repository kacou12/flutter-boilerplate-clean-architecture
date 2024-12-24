import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my/core/api/api.dart';

abstract class ApiResult<T> {
  static const String _jsonNodeData = 'data';

  static const String _jsonNodeToken = 'token';
  static const String _jsonNodeRefreshToken = 'refresh_token';

  static T fromResponse<T>(
      {required Response response,
      required T Function(dynamic) mapper} // Map<String, dynamic> or List<T>
      ) {
    Map<String, dynamic> responseData;

    responseData = response.data as Map<String, dynamic>;

    if ((response.requestOptions.path.contains(ListAPI.login)
        // ||
        // response.requestOptions.path.contains('user/email/verify') ||
        // response.requestOptions.path.contains('user/google/auth') ||
        // response.requestOptions.path.contains('user/facebook/auth')
        )) {
      Map<String, dynamic> items = {};

      // Get token
      if (responseData.containsKey(_jsonNodeData) &&
          responseData[_jsonNodeData] is Map &&
          (responseData[_jsonNodeData] as Map).containsKey(_jsonNodeToken)) {
        items = responseData[_jsonNodeData]['user'];

        items[_jsonNodeToken] = responseData[_jsonNodeData][_jsonNodeToken];
        items[_jsonNodeRefreshToken] =
            responseData[_jsonNodeData][_jsonNodeRefreshToken];
      }
      return mapper(items);
    }
    return mapper(responseData[_jsonNodeData]);
  }
}
