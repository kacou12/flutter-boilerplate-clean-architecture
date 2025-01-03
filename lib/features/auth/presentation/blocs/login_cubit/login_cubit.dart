import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my/core/errors/failures.dart';
import 'package:my/features/auth/domain/entities/user.dart';
import 'package:my/features/auth/domain/repositories/auth_repository.dart';
import 'package:my/features/auth/domain/usecases/login_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginCase) : super(LoginInitial());
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  final LoginCase loginCase;

  Future<void> login(RequestParamsLogin params) async {
    emit(LoginLoading());
    final data = await loginCase.call(params);

    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(LoginFailure(message: l.message));
        }
      },
      (r) => emit(LoginSuccess(user: r)),
    );
  }
}
