import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my/core/core.dart';
import 'package:my/core/resources/resources.dart';
import 'package:my/core/services/injection_container.dart';
import 'package:my/core/services/router/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class MyApp extends StatelessWidget {
  final router = sl<AppRouter>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<AuthBloc>(),
            ),

            // Vous pouvez ajouter plus de blocs/providers ici
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            title: HelperConstants.appName,
            theme: themeLight(context),
            darkTheme: themeDark(context),
            locale: const Locale('en', 'EN'),
            supportedLocales: const [
              Locale('en', ''),
              Locale('fr', ''),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          )),
    );
  }
}
