part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, splash, unknown }

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthStatusChanged extends AuthEvent {
  final AuthStatus status;

  const AuthStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}

final class AuthLogoutRequest extends AuthEvent {}

final class AuthRead extends AuthEvent {}
