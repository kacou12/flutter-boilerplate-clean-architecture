import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:swiit/src/core/core.dart';
import 'package:swiit/src/features/auth/presentation/bloc/bloc.dart';

class SignUpOtpStep extends StatefulWidget {
  const SignUpOtpStep({
    super.key,
    this.onNext,
    this.continueValue,
    this.continueOnEditInteretPage,
    this.email,
  });
  final bool? continueValue;
  final String? email;
  final VoidCallback? onNext;
  final bool? continueOnEditInteretPage;
  @override
  State<SignUpOtpStep> createState() => _SignUpOtpStepState();
}

class _SignUpOtpStepState extends State<SignUpOtpStep> {
  late Timer _timer;
  bool resend = false;
  int countResend = 180;
  final otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text("Otp verification failed: ${state.errorMsg}"),
              ),
            );
        }
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text("Otp verified successfully"),
              ),
            );
          if (widget.continueOnEditInteretPage == true) {
            context.goNamed(PageRoutes.editInterests,
                extra: {"restartOnFeedPage": true});
          } else {
            context.go(PageRoutes.feedRoute);
          }
        }
      },
      builder: (BuildContext context, RegisterState state) {
        return Scaffold(
          appBar:
              AppBar(backgroundColor: Colors.white, leading: const SizedBox()),
          body: Material(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Otp code",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            Text(
                              "Select credentials which should we use to verify your account.",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Otp",
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Pinput(
                              autofocus: true,
                              length: 6,
                              controller: otpController,
                              onCompleted: (pin) async {
                                debugPrint("Completed: $pin");
                                log(widget.email!, name: "Show before email");
                                context.read<RegisterBloc>().add(
                                    RegisterEvent.verifyEmail(
                                        otpController.text, widget.email!));
                              },
                              onSubmitted: (pin) {
                                if (pin.length == 6) {
                                  log(widget.email!, name: "Show before email");
                                  context
                                      .read<RegisterBloc>()
                                      .add(RegisterEvent.verifyEmail(
                                        otpController.text,
                                        widget.email!,
                                        // state.
                                      ));
                                }
                              },
                              defaultPinTheme: PinTheme(
                                width: 63,
                                height: 45,
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  )),
                                  // borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Didn't receive code?",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                SizedBox(width: 10.w),
                                resend && countResend != 0
                                    ? Text(formatTime(countResend))
                                    : TextButton(
                                        onPressed: () {
                                          setState(() {
                                            resend = true;
                                          });
                                          _timer = Timer.periodic(
                                              const Duration(seconds: 1),
                                              (timer) {
                                            if (countResend == 0) {
                                              timer.cancel();
                                              setState(() {
                                                resend = false;
                                                countResend = 180;
                                              });
                                            } else {
                                              setState(() {
                                                countResend--;
                                              });
                                            }
                                          });
                                          context.read<RegisterBloc>().add(
                                              RegisterEvent.resendOTP(
                                                  widget.email!));
                                        },
                                        child: const Text("Resend code")),
                              ],
                            )
                          ],
                        ),
                      ),
                      // TextButton(
                      //     onPressed: () {
                      //       context.read<RegisterBloc>().add(
                      //           RegisterEvent.resendOTP(state.email.value));
                      //     },
                      //     child: const Text("Resend code")),
                      // SubmitButton(
                      //     title: "Submit",
                      //     onTap: () {
                      //       // context
                      //       //     .read<RegisterBloc>()
                      //       //     .add(RegisterEvent.verifyEmail(otpController.text));
                      //       // widget.onNext();
                      //     })
                    ],
                  ),
                ),
                if (state.status.isInProgress)
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xfff1F1F1).withOpacity(.05)),
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
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  decompter() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (countResend > 0) {
          countResend--;
        } else {
          _timer.cancel();
          setState(() {
            resend = true;
          });
        }
      });
    });
  }
}

String formatTime(int totalSeconds) {
  int minutes = totalSeconds ~/ 60;
  int seconds = totalSeconds % 60;

  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
