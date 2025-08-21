import 'package:my/core/usecase/usecase.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/domain/entities/user.dart';
import 'package:my/features/auth/domain/repositories/auth_repository.dart';

class CurrentUserCase implements UseCase<User?, NoParams> {
  CurrentUserCase(this.repository);

  final AuthRepository repository;

  @override
  FutureResult<User?> call(NoParams params) async {
    return repository.currentUser;
  }
}
