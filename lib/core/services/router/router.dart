import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my/core/layout/bottom_navigation_bar.dart';
import 'package:my/core/services/hive/hive.dart';
import 'package:my/core/services/injection_container.dart';
import 'package:my/core/services/router/page_routes.enum.dart';
import 'package:my/core/services/router/router_observer.dart';
import 'package:my/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:my/features/auth/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:my/features/auth/presentation/pages/login_screen.dart';
import 'package:my/features/auth/presentation/pages/onboarding_screen.dart';
import 'package:my/features/auth/presentation/pages/register_screen.dart';
import 'package:my/features/chat/chat_screen.dart';
import 'package:my/features/general/pages/splash_screen.dart';
import 'package:my/features/products/products_screen.dart';
import 'package:my/features/settings/settings_screen.dart';
import 'package:my/features/users/users_profil_screen.dart';
import 'package:my/features/users/users_screen.dart';

part 'router.main.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final _userNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: PageRoutes.userHome.name,
);
final _chatNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: PageRoutes.chat.name,
);
final _settingsNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: PageRoutes.settings.name,
);
final _productsNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: PageRoutes.products.name,
);
