import 'package:get_it/get_it.dart';
import 'package:my/core/api/dio_client.dart';
import 'package:my/core/services/hive/hive.dart';
import 'package:my/core/services/router/router.dart';
import 'package:my/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:my/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:my/features/auth/domain/repositories/auth_repository.dart';
import 'package:my/features/auth/domain/usecases/current_user_case.dart';
import 'package:my/features/auth/domain/usecases/login_case.dart';
import 'package:my/features/auth/domain/usecases/logout_case.dart';
import 'package:my/features/auth/domain/usecases/my_profile_case.dart';
import 'package:my/features/auth/domain/usecases/register_case.dart';
import 'package:my/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:my/features/auth/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:my/features/auth/presentation/blocs/register_cubit/register_cubit.dart';

part 'injection_container.main.dart';
