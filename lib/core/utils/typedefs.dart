import 'package:dartz/dartz.dart';
import 'package:my/core/errors/failures.dart';

typedef DataMap = Map<String, dynamic>;
typedef RightResult<T> = Right<Failure, T>;
typedef FutureResult<T> = Future<Either<Failure, T>>;
typedef FutureEitherResult<T> = Future<Either<ServerFailure, T>>;
typedef ResponseConverter<T> = T Function(dynamic response);

typedef FromJsonFunction<T> = T Function(Map<String, dynamic>);
typedef ToJsonFunction<T> = Map<String, dynamic> Function(T);

typedef FromJsonFunctionList<T> = List<T> Function(List<dynamic>);
typedef ToJsonFunctionList<T> = List<Map<String, dynamic>> Function(List<T>);
