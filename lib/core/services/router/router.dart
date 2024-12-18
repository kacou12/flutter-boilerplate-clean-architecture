import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my/core/services/hive/hive.dart';
import 'package:my/core/services/injection_container.dart';
import 'package:my/core/services/router/page_routes.enum.dart';
import 'package:my/core/services/router/router_observer.dart';
import 'package:my/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:my/features/auth/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:my/features/auth/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:my/features/auth/presentation/pages/login_screen.dart';
import 'package:my/features/auth/presentation/pages/register_screen.dart';
import 'package:my/features/general/pages/splash_screen.dart';
import 'package:my/features/users/users_screen.dart';

part 'router.main.dart';
