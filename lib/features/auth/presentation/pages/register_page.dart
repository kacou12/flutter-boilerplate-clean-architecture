import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my/features/auth/presentation/pages/sign_up_first_step.dart';

import '../../../../core/core.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    shadows: const [],
                    size: 21.sp,
                  )),
            ),
            body: SignUpFirstStep(
              onNext: () {
                // context.goNamed(PageRoutes.signUpOtpStep, extra: {
                //   "continue": true,
                //   "email": context.read<RegisterBloc>().state.email.value,
                //   "continueOnEditInteretPage": true,
                // });
              },
            )),
        Align(
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              if (state.status.isInProgress) {
                return Container(
                  width: 1.sw,
                  height: 1.sh,
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(.09)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 7.w, bottom: 30.h),
                        height: 25.h,
                        width: 25.h,
                        child: const CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          // backgroundColor: MyColorName.greyText,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        )
      ],
    );
  }
}
