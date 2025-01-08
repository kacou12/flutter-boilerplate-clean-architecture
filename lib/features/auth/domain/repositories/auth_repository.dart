import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/data/payload/request_params_login_payload.dart';
import 'package:my/features/auth/data/payload/request_params_register_payload.dart';
import 'package:my/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  FutureResult<User> login(RequestParamsLoginPayload request);
  FutureResult<User> myProfile();
  FutureResult<User> register(RequestParamsRegisterPayload request);
  FutureResult<void> loggout();
  FutureResult<User?> get currentUser;
}
