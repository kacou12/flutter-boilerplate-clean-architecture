import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my/core/usecase/usecase.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/domain/entities/user.dart';
import 'package:my/features/auth/domain/usecases/current_user_case.dart';
import 'package:my/features/auth/domain/usecases/logout_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.currentUser, this.logout) : super(AuthState.unknown()) {
    on(_call);
  }

  final CurrentUserCase currentUser;

  final LogoutCase logout;

  Future<void> _call(AuthEvent event, Emitter<AuthState> emit) async {
    switch (event) {
      case AuthStatusChanged():
        final statusEvent = event;
        final status = statusEvent.status;

        if (status == AuthStatus.unauthenticated) {
          emit(AuthState.unauthenticated());
          // emit(const AuthState(status: AuthStatus.unauthenticated, user: null));
        } else if (status == AuthStatus.authenticated) {
          final result = await currentUser.call(NoParams());

          if (result is RightResult<User?> && result.value != null) {
            await Future.delayed(const Duration(seconds: 2));
            emit(
              AuthState.authenticated(result.value!),
            );
          } else {
            emit(AuthState.unauthenticated());
          }
        }

      case AuthLogoutRequest():
        await logout.call(NoParams());
        emit(AuthState.unauthenticated());

      case AuthRead():
        // if (state.isAuthenticated) {
        final userData = await currentUser.call(NoParams());

        if (userData is RightResult<User?> && userData.value != null) {
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
