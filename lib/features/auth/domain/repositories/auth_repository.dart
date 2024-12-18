import 'package:equatable/equatable.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  FutureResult<User> login(RequestParamsLogin request);
  FutureResult<User> myProfile();
  FutureResult<User> register(RequestParamsRegister request);
  FutureResult<void> loggout();
  FutureResult<User> get currentUser;
}

// PARAMS
class RequestParamsLogin extends Equatable {
  const RequestParamsLogin({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class RequestParamsRegister extends Equatable {
  const RequestParamsRegister({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
  });
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        phone,
      ];
}
