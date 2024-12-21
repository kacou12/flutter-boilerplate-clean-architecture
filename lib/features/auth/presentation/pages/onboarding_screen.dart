import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my/core/resources/images.dart';
import 'package:my/core/services/router/page_routes.enum.dart';
import 'package:my/core/widgets/buttons/submit_button.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Image(image: AssetImage(Images.icLauncher)),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          "Welcome back, login to continue !",
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 12.sp),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Container(
          margin: EdgeInsets.only(right: 30.w),
          child: Row(
            children: [
              Expanded(
                  child: SubmitButton(
                      title: "Se connecter",
                      isOutlined: true,
                      onTap: () {
                        context.pushNamed(PageRoutes.login.name);
                      })),
              SizedBox(
                width: width * 0.04,
              ),
              Expanded(
                  child: SubmitButton(
                title: "S'inscrire",
                onTap: () {
                  context.pushNamed(PageRoutes.register.name);
                },
              ))
            ],
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    ));
  }
}
