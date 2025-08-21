part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
  });

  final AuthStatus status;
  final UserModel? user;

  get isAuthenticated => status == AuthStatus.authenticated;

  get isUnauthenticated => status == AuthStatus.unauthenticated;

  factory AuthState.unknown() =>
      const AuthState(status: AuthStatus.unknown, user: null);

  factory AuthState.authenticated(UserModel user) =>
      AuthState(status: AuthStatus.authenticated, user: user);

  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated, user: null);

  @override
  List<Object?> get props => [status, user];
}
