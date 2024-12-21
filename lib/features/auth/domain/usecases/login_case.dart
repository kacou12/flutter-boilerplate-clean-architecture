
import 'package:my/core/usecase/usecase.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/domain/entities/user.dart';
import 'package:my/features/auth/domain/repositories/auth_repository.dart';

class LoginCase implements UseCase<User, RequestParamsLogin> {
  LoginCase(this.repository);

  final AuthRepository repository;

  @override
  FutureResult<User> call(RequestParamsLogin params) async {
    return repository.login(params);
  }
}
