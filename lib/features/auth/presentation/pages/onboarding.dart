import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my/core/widgets/buttons/submit_button.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 150,
          child: Image(image: AssetImage("assets/icons/swiit_logo_white.png")),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          "Welcome back, login to continue !",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 12.sp),
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
                        //  context.push(AppRoute.signInRoute),
                      })),
              SizedBox(
                width: width * 0.04,
              ),
              Expanded(
                  child: SubmitButton(
                title: "S'inscrire",
                onTap: () {
                  // context.push(PageRoutes.signUpRoute);
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
