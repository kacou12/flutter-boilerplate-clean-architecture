import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:my/core/resources/images.dart';
import 'package:my/core/services/router/page_routes.enum.dart';
import 'package:my/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthRead());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        Future.delayed(const Duration(seconds: 3), () {
          if (context.mounted) {
            if (state.isAuthenticated) {
              return context.goNamed(PageRoutes.userHome.name);
            }
            return context.goNamed(PageRoutes.login.name);
          }
        });
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.icLauncher),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.icLogo,
                      color: Colors.white,
                      height: 40.h,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'AFitterWorld',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(right: 7.w, bottom: 30.h),
                  height: 20.h,
                  width: 20.h,
                  child: const CircularProgressIndicator.adaptive(
                    strokeWidth: 1,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    // backgroundColor: MyColorName.greyText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
