import 'package:my/core/usecase/usecase.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/domain/entities/user.dart';
import 'package:my/features/auth/domain/repositories/auth_repository.dart';

class RegisterCase implements UseCase<User, RequestParamsRegister> {
  RegisterCase(this.repository);

  final AuthRepository repository;

  @override
  FutureResult<User> call(RequestParamsRegister params) async {
    return repository.register(params);
  }
}
