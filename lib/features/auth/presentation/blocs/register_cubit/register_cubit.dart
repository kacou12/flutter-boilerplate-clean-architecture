import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my/core/errors/failures.dart';
import 'package:my/features/auth/data/models/user_model.dart';
import 'package:my/features/auth/data/repositories/auth/auth_repository.dart';
import 'package:my/features/auth/data/repositories/auth/auth_repository_impl.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepositoryImpl) : super(RegisterInitial());

  final AuthRepositoryImpl authRepositoryImpl;

  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  Future<void> register(RequestParamsRegister params) async {
    emit(RegisterLoading());
    final data = await authRepositoryImpl.register(params);
    data.fold((l) {
      if (l is ServerFailure) {
        emit(RegisterFailure(message: l.message));
      }
    }, (r) => emit(RegisterSuccess(user: r)));
  }
}
