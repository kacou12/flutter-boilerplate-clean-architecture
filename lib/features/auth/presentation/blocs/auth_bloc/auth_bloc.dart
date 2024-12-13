import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my/core/usecase/usecase.dart';
import 'package:my/core/utils/typedefs.dart';
import 'package:my/features/auth/domain/entities/user.dart';
import 'package:my/features/auth/domain/usecases/current_user_case.dart';
import 'package:my/features/auth/domain/usecases/logout_case.dart';
import 'package:my/features/auth/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:my/features/auth/presentation/blocs/register_cubit/register_cubit.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.currentUser,
    required this.logout,
    required this.loginCubit,
    required this.registerCubit,
  }) : super(const AuthState.unknown()) {
    on(_call);

    loginSubscription = loginCubit.stream.listen((loginState) {
      if (loginState is LoginSuccess) {
        // IF USER DATA IS NOT DIRECTLY IN LoginSuccess STATE
        add(const AuthStatusChanged(AuthStatus.authenticated));
      }
    });

    _subscription =
        currentUser.call(NoParams()).asStream().listen((result) async {
      if (result is RightResult<User?> &&
          result.value != null &&
          result.value?.id != -1 &&
          result.value!.token != null) {
        // log("Implicite Login success", name: "AppBloc");
        add(const AuthStatusChanged(AuthStatus.authenticated));
      } else {
        add(const AuthStatusChanged(AuthStatus.unauthenticated));
      }
    });
  }

  late final StreamSubscription<dynamic> _subscription;
  late final StreamSubscription<dynamic> loginSubscription;

  final CurrentUserCase currentUser;
  final LoginCubit loginCubit;
  final RegisterCubit registerCubit;
  final LogoutCase logout;

  Future<void> _call(AuthEvent event, Emitter<AuthState> emit) async {
    switch (event) {
      case AuthStatusChanged():
        final statusEvent = event;
        final status = statusEvent.status;

        if (status == AuthStatus.unauthenticated) {
          emit(const AuthState.unauthenticated());
        } else if (status == AuthStatus.authenticated) {
          final result = await currentUser.call(NoParams());

          if (result is RightResult<User?> && result.value != null) {
            await Future.delayed(const Duration(seconds: 2));
            emit(
              AuthState.authenticated(result.value!),
            );
          } else {
            emit(const AuthState.unauthenticated());
          }
        }
        break;

      case AuthLogoutRequest():
        await logout.call(NoParams());
        emit(const AuthState.unauthenticated());
        break;

      case AuthRead():
        if (state.status == AuthStatus.authenticated) {
          final userData = await currentUser.call(NoParams());

          if (userData is RightResult<User?> && userData.value != null) {
            emit(
              AuthState.authenticated(userData.value!),
            );
          }
        }
        break;

      default:
        log('Unhandled event type: ${event.runtimeType}', name: 'AppBloc');
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
