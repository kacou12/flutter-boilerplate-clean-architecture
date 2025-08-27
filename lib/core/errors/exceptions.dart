import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  const CacheException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class RequestException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic response;

  const RequestException({
    required this.message,
    required this.statusCode,
    this.response,
  });

  factory RequestException.fromDioError(DioException error) {
    try {
      String message = "";
      if (error.response?.data != null) {
        // final data = json.decode(error.response?.data);
        final data = error.response?.data;
        if (data is Map) {
          message = data["error"].toString();
        }
      } else {
        message = error.toString();
      }

      return RequestException(
        statusCode: error.response?.statusCode,
        message: message,
        response: error.response?.data,
      );
    } on Error {
      return const RequestException(statusCode: -2, message: 'UNKNOWN_ISSUE');
    }
  }

  factory RequestException.fromJson(Map<String, dynamic> json) {
    if (json['waitingTime'] != null) {
      return RequestException(
        message: json['message'].toString(),
        statusCode: json['statusCode'] as int,
        response: json['waitingTime'],
      );
    }
    return RequestException(
      message: json['message'].toString(),
      statusCode: json['statusCode'] as int,
      response: json['response'],
    );
  }

  @override
  String toString() =>
      "RequestException:\n\tcode: $statusCode\n\tmessage:$message \n\rresponse:$response";
}

class StorageException implements Exception {
  final String message;
  final dynamic cause;

  StorageException(this.message, [this.cause]);

  @override
  String toString() =>
      'StorageException: $message${cause != null ? ' (caused by: $cause)' : ''}';
}
