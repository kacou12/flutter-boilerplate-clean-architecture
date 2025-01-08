import 'package:my/core/usecase/usecase.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/data/payload/request_params_login_payload.dart';
import 'package:my/features/auth/domain/entities/user.dart';
import 'package:my/features/auth/domain/repositories/auth_repository.dart';

class LoginCase implements UseCase<User, RequestParamsLoginPayload> {
  LoginCase(this.repository);

  final AuthRepository repository;

  @override
  FutureResult<User> call(RequestParamsLoginPayload params) async {
    return repository.login(params);
  }
}
