import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my/core/errors/failures.dart';
import 'package:my/features/auth/domain/entities/user.dart';
import 'package:my/features/auth/domain/repositories/auth_repository.dart';
import 'package:my/features/auth/domain/usecases/register_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterCase registerCase;

  RegisterCubit(this.registerCase) : super(RegisterInitial());

  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  Future<void> register(RequestParamsRegister params) async {
    emit(RegisterLoading());
    final data = await registerCase.call(params);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(RegisterFailure(message: l.message));
        }
      },
      (r) => emit(RegisterSuccess(user: r)),
    );
  }
}
