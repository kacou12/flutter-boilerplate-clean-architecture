part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final User user;

  const RegisterSuccess({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

final class RegisterFailure extends RegisterState {
  final String message;

  const RegisterFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
