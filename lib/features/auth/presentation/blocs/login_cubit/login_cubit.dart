import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my/core/errors/failures.dart';
import 'package:my/features/auth/data/models/user_model.dart';
import 'package:my/features/auth/data/repositories/auth/auth_repository.dart';
import 'package:my/features/auth/data/repositories/auth/auth_repository_impl.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepositoryImpl) : super(LoginInitial());
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  final AuthRepositoryImpl authRepositoryImpl;

  Future<void> login(RequestParamsLogin params) async {
    emit(LoginLoading());
    final data = await authRepositoryImpl.login(params);

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
