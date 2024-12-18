import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my/core/resources/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
                    image: AssetImage(Images.icLauncher), fit: BoxFit.cover),
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
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'AFitterWorld',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  )
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
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                  // backgroundColor: MyColorName.greyText,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
