import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:swiit/src/core/router/page_route.dart';
import 'package:swiit/src/features/auth/presentation/widgets/submit_button.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late VideoPlayerController _videoController;
  @override
  void initState() {
    super.initState();
    _initVideoController();
  }

  void _initVideoController() {
    _videoController =
        VideoPlayerController.asset("assets/videos/production.mp4")
          ..initialize().then((_) {
            _videoController.play();
            _videoController.setLooping(true);
            setState(() {});
          });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //video
          FittedBox(
            fit: BoxFit.cover,
            child: _videoController.value.isInitialized
                ? SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController))
                : null,
          ),

          //overlay color
          const ColoredBox(color: Colors.black45),
          Positioned(
              bottom: height * 0.02,
              left: width * 0.04,
              right: width * 0.04,
              child: Column(
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
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 12.sp),
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
                          onTap: () => context.push(PageRoutes.signInRoute),
                        )),
                        SizedBox(
                          width: width * 0.04,
                        ),
                        Expanded(
                            child: SubmitButton(
                          title: "S'inscrire",
                          onTap: () {
                            context.push(PageRoutes.signUpRoute);
                          },
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
