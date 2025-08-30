import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/data/repositories/auth/forgot_password_repository_impl.dart';
import 'package:my/features/auth/presentation/blocs/forget_password_bloc/forgot_password_event.dart';
import 'package:my/features/auth/presentation/blocs/forget_password_bloc/forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordRepositoryImpl repository;

  ForgotPasswordBloc({required this.repository})
    : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEmailSubmitted>(_onEmailSubmitted);
    on<ForgotPasswordCodeSubmitted>(_onCodeSubmitted);
    on<NewPasswordSubmitted>(_onNewPasswordSubmitted);
    on<ForgotPasswordReset>(_onReset);
  }

  Future<void> _onEmailSubmitted(
    ForgotPasswordEmailSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());

    try {
      final result = await repository.sendPasswordReset(event.email);
      if (result is RightResult<Map<String, String>>) {
        emit(ForgotPasswordEmailSent(result.value['email'] ?? ''));
      }
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }

  Future<void> _onCodeSubmitted(
    ForgotPasswordCodeSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());

    try {
      final isValid = await repository.verifyResetCode(event.code);
      if (isValid is RightResult<bool>) {
        emit(ForgotPasswordCodeVerified());
      } else {
        emit(const ForgotPasswordFailure('Code incorrect'));
      }
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }

  Future<void> _onNewPasswordSubmitted(
    NewPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());

    try {
      final success = await repository.resetPassword(
        event.newPassword,
        event.confirmPassword,
      );
      if (success is RightResult<bool>) {
        emit(ForgotPasswordSuccess());
      } else {
        emit(const ForgotPasswordFailure('Erreur lors de la réinitialisation'));
      }
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }

  void _onReset(ForgotPasswordReset event, Emitter<ForgotPasswordState> emit) {
    emit(ForgotPasswordInitial());
  }
}
