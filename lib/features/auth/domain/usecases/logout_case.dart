import 'package:my/core/usecase/usecase.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/domain/repositories/auth_repository.dart';

class LogoutCase implements UseCase<void, NoParams> {
  LogoutCase(this.repository);

  final AuthRepository repository;

  @override
  FutureResult<void> call(NoParams params) async {
    return repository.loggout();
  }
}
