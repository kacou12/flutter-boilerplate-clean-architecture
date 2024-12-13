import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pinput.dart';
import 'package:swiit/gen/assets.gen.dart';
import 'package:swiit/injection_container.dart';
import 'package:swiit/src/core/core.dart';
import 'package:swiit/src/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:swiit/src/features/auth/presentation/bloc/verify_otp/verify_otp_bloc.dart';
import 'package:swiit/src/features/auth/presentation/bloc/verify_otp/verify_otp_event.dart';
import 'package:swiit/src/features/auth/presentation/bloc/verify_otp/verify_otp_state.dart';
import 'package:swiit/src/features/auth/presentation/widgets/submit_button.dart';

class VerifyAccountWithOtpPage extends StatefulWidget {
  const VerifyAccountWithOtpPage({super.key, required this.account});

  final RequestParamsForgotPassword account;

  @override
  State<VerifyAccountWithOtpPage> createState() =>
      _VerifyAccountWithOtpPageState();
}

class _VerifyAccountWithOtpPageState extends State<VerifyAccountWithOtpPage> {
  late OTPTextEditController controller;

  late OTPInteractor _otpInteractor;

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initInteractor();
    controller = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) {
        setState(() {
          controller.text = code;
        });
      },
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');

          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [
          // SampleStrategy(),
        ],
      );
    // observerControl();
  }

  Future<void> _initInteractor() async {
    _otpInteractor = OTPInteractor();

    // You can receive your app signature by using this method.
    final appSignature = await _otpInteractor.getAppSignature();

    if (kDebugMode) {
      print('Your app signature: $appSignature');
    }
  }

  @override
  void dispose() {
    controller.stopListen();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Colors.purple;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Colors.grey;

    final defaultPinTheme = PinTheme(
      width: 40.h,
      height: 40.h,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        border: Border.all(color: borderColor),
      ),
    );
    return BlocProvider(
      create: (context) => sl<VerifyOTPBloc>(),
      child: BlocListener<VerifyOTPBloc, VerifyOtpState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            context
                .read<VerifyOTPBloc>()
                .add(VerifyOtpEvent.codeOTP(state.code.value));
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text(state.errorMsg),
                ),
              );
          } else if (state.isValid && state.status.isSuccess) {
            context.push(PageRoutes.resetPasswordRoute,
                extra: RequestParamsResetPasswordWithToken(
                    email: widget.account.value, token: state.code.value));
          }
        },
        child: Scaffold(
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
              centerTitle: true,
              title: Image.asset(
                MyAssets.icons.swiitLogo.path,
                height: 20.h,
              )
              // Text(
              //   'Swiit',
              //   style: GoogleFonts.poppins(fontSize: 27.sp),
              // ),
              ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 40.r,
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        'Vérification de compte'.toUpperCase(),
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (widget.account.type == TypeRecoveryPassword.email)
                        Text(
                          'Renseignez entrer l\'OTP qui a été envoyé à votre adresse e-mail\n${widget.account.value}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 8.sp),
                        ),
                      if (widget.account.type == TypeRecoveryPassword.tel)
                        Text(
                          'Renseignez les informations d\'identifications afin de récupérer votre mot de passe',
                          style: GoogleFonts.poppins(fontSize: 8.sp),
                        ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'OTP',
                            style: GoogleFonts.poppins(fontSize: 8.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      BlocBuilder<VerifyOTPBloc, VerifyOtpState>(
                          buildWhen: (previous, current) =>
                              previous.code.value != current.code.value,
                          builder: (context, state) {
                            return Directionality(
                              textDirection: TextDirection.ltr,
                              child: Pinput(
                                length: 6,
                                controller: pinController
                                  ..text =
                                      state.code.isPure ? '' : state.code.value
                                  ..selection = TextSelection.collapsed(
                                    offset: pinController.text.length,
                                  ),
                                focusNode: focusNode,
                                defaultPinTheme: defaultPinTheme,
                                hapticFeedbackType:
                                    HapticFeedbackType.lightImpact,
                                onCompleted: (pin) {
                                  debugPrint('onCompleted: $pin');
                                },
                                onChanged: (value) {
                                  context.read<VerifyOTPBloc>().add(
                                        VerifyOtpEvent.codeOTP(
                                          value,
                                        ),
                                      );
                                  if (value.length == 6) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  }
                                },
                                cursor: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 9,
                                      ),
                                      width: 22,
                                      height: 1,
                                      color: focusedBorderColor,
                                    ),
                                  ],
                                ),
                                focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration:
                                      defaultPinTheme.decoration!.copyWith(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    border: Border.all(
                                      color: focusedBorderColor,
                                    ),
                                  ),
                                ),
                                submittedPinTheme: defaultPinTheme.copyWith(
                                  decoration:
                                      defaultPinTheme.decoration!.copyWith(
                                    color: fillColor,
                                    borderRadius: BorderRadius.circular(8.sp),
                                    border: Border.all(
                                      color: focusedBorderColor,
                                    ),
                                  ),
                                ),
                                errorPinTheme: defaultPinTheme.copyBorderWith(
                                  border: Border.all(color: Colors.redAccent),
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 15.h,
                      ),
                      BlocBuilder<VerifyOTPBloc, VerifyOtpState>(
                        builder: (context, state) {
                          return SubmitButton(
                              title: "Vérifier",
                              onTap: () {
                                context
                                    .read<VerifyOTPBloc>()
                                    .add(VerifyOtpEvent.submit());
                              });
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      BlocBuilder<VerifyOTPBloc, VerifyOtpState>(
                        builder: (context, state) {
                          return RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                  fontSize: 8.sp, color: Colors.black),
                              text: "Vous n'avez pas reçu de code? ",
                              children: [
                                TextSpan(
                                  style: GoogleFonts.poppins(
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.bold),
                                  text: " Renvoyez le code",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context
                                          .read<VerifyOTPBloc>()
                                          .add(VerifyOtpEvent.resendOTP());
                                    },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info,
                            size: 10.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 8.sp),
                              text:
                                  "Si vous ne trouver pas le code OTP dans votre boite mail, merci de consulter vos",
                              children: const [],
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 8.sp),
                          text: "spams ou sélectionner ",
                          children: [
                            TextSpan(
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 7.sp,
                                  fontWeight: FontWeight.bold),
                              text: "recevoir par SMS",
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<VerifyOTPBloc, VerifyOtpState>(
                builder: (context, state) {
                  if (state.status.isInProgress) {
                    return Container(
                      decoration: BoxDecoration(
                          color: const Color(0xfff1F1F1).withOpacity(.5)),
                      child: const SpinKitCircle(
                        color: Colors.black,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
