part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
  });

  final AuthStatus status;
  final User? user;

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}
