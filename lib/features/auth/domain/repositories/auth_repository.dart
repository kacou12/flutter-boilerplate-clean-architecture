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

// typedef IAuthRepositoryResult = Either<ServerFailure, User>;
// typedef IAuthRepositoryLogout = Either<ServerFailure, bool>;
// typedef IAuthRepositoryCurrentUser = Either<Failure, User?>;
// typedef IAuthRepositoryVoid = Either<Failure, void>;
// typedef IAuthRepositoryUpdatePassword = Either<Failure, bool>;
// typedef IAuthRepositoryUpdatPrivacyAccount = Either<Failure, bool>;
// typedef IAuthRepositoryResetPasswordWithEmail = Either<Failure, bool>;
// typedef IAuthRepositorySendOTPForVerifyAccount = Either<Failure, bool>;
// typedef IAuthRepositoryVerifyEmail = Either<Failure, User>;
// typedef IAuthRepositoryResendOtp = Either<Failure, bool>;
// typedef IAuthRepositoryUpdateProfile = Either<Failure, User>;

// PARAMS
class RequestParamsLogin extends Equatable {
  const RequestParamsLogin({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class RequestParamsRegister extends Equatable {
  const RequestParamsRegister(
      {required this.userName,
      required this.name,
      required this.email,
      required this.password,
      required this.sponsor,
      required this.country,
      required this.city,
      required this.phone,
      required this.deviceId,
      required this.deviceType,
      this.image});
  final String userName;
  final String name;
  final String email;
  final String password;

  final String sponsor;
  final String country;
  final String phone;
  final String city;
  final String deviceId;
  final String deviceType;
  final String? image;

  @override
  List<Object?> get props => [
        userName,
        name,
        email,
        password,
        sponsor,
        country,
        city,
        city,
        phone,
        deviceId,
        deviceType,
        image
      ];
}
