import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/data/models/user_model.dart';
import 'package:my/features/auth/data/repositories/auth/auth_repository_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepositoryImpl) : super(AuthState.unknown()) {
    on(_call);
  }

  final AuthRepositoryImpl authRepositoryImpl;

  Future<void> _call(AuthEvent event, Emitter<AuthState> emit) async {
    switch (event) {
      case AuthStatusChanged():
        final statusEvent = event;
        final status = statusEvent.status;

        if (status == AuthStatus.unauthenticated) {
          emit(AuthState.unauthenticated());
          // emit(const AuthState(status: AuthStatus.unauthenticated, user: null));
        } else if (status == AuthStatus.authenticated) {
          final result = await authRepositoryImpl.currentUser;

          if (result is RightResult<UserModel?> && result.value != null) {
            await Future.delayed(const Duration(seconds: 2));
            emit(
              AuthState.authenticated(result.value!),
            );
          } else {
            emit(AuthState.unauthenticated());
          }
        }

      case AuthLogoutRequest():
        await authRepositoryImpl.loggout();
        emit(AuthState.unauthenticated());

      case AuthRead():
        // if (state.isAuthenticated) {
        final userData = await authRepositoryImpl.currentUser;

        if (userData is RightResult<UserModel?> && userData.value != null) {
          emit(
            AuthState.authenticated(userData.value!),
          );
        } else {
          emit(
            AuthState.unauthenticated(),
          );
        }
      // }
    }
  }

  // @override
  // Future<void> close() {
  //   // _subscription.cancel();
  //   _loginSubscription.cancel();
  //   return super.close();
  // }
}
