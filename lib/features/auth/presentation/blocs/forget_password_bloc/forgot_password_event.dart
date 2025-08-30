import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEmailSubmitted extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordEmailSubmitted(this.email);

  @override
  List<Object> get props => [email];
}

class ForgotPasswordCodeSubmitted extends ForgotPasswordEvent {
  final String code;

  const ForgotPasswordCodeSubmitted(this.code);

  @override
  List<Object> get props => [code];
}

class NewPasswordSubmitted extends ForgotPasswordEvent {
  final String newPassword;
  final String confirmPassword;

  const NewPasswordSubmitted(this.newPassword, this.confirmPassword);

  @override
  List<Object> get props => [newPassword, confirmPassword];
}

class ForgotPasswordReset extends ForgotPasswordEvent {}
