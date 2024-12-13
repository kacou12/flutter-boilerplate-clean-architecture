import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiit/injection_container.dart';
import 'package:swiit/src/core/core.dart';
import 'package:swiit/src/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:swiit/src/features/auth/presentation/bloc/bloc.dart';
import 'package:swiit/src/features/auth/presentation/widgets/form_input_text.dart';
import 'package:swiit/src/features/auth/presentation/widgets/submit_button.dart';
import 'package:video_player/video_player.dart';

import '../../../clubs/presentation/widgets/form_text_field.dart';
import '../../../profile/presentation/cubit/profil/profil_cubit.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late VideoPlayerController _controller;
  ValueNotifier<int> viewsIndex = ValueNotifier(0);
  String? focusedField;
  List<double> modalHeight = [];

  @override
  void initState() {
    super.initState();
    _initVideoController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initVideoController() {
    _controller = VideoPlayerController.asset("assets/videos/production.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocListener<AppBloc, AppState>(
      listener: (context, state) async {
        if (state.user != null && state.user?.id != null) {
          if (state.status == AppStatus.authenticated) {
            while (context.canPop()) {
              context.pop();
            }
            context.pushReplacement(PageRoutes.feedRoute);
          }
        }
      },
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: MultiBlocListener(
            listeners: [
              BlocListener<LoginBloc, LoginState>(
                listener: (context, loginState) {
                  if (loginState.status.isFailure) {
                    context.read<LoginBloc>().add(
                        LoginEvent.passwordChanged(loginState.password.value));
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text(loginState.errorMsg),
                        ),
                      );
                  }
                  if (loginState.status.isSuccess && !loginState.emailIsValid) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Email not verified'),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(0),
                              ),
                            ),
                            content: const Text(
                                "Votre email n'est pas vérifié. Vous voulez-vous le vérifier ?"),
                            actions: [
                              BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) => TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      context.read<RegisterBloc>().resendOtp(
                                          ResendOtpParams(
                                              provider:
                                                  loginState.currentEmail));
                                      context.pushNamed(
                                          PageRoutes.signUpOtpStep,
                                          extra: {
                                            "continue": false,
                                            "email": loginState.currentEmail
                                          });
                                    },
                                    child: const Text('OUI')),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('NON')),
                            ],
                          );
                        });
                    // return;
                  } else if (loginState.status.isSuccess &&
                      loginState.socialConnected == true) {
                    // show dialog for change username
                    final TextEditingController newUserNameController =
                        TextEditingController(text: loginState.userName ?? "");
                    ShowAlertDialogForChangeUserName(
                        context, newUserNameController);
                  } else if (loginState.isValid &&
                      loginState.status.isSuccess) {
                    print('</> success');
                    context
                        .read<AppBloc>()
                        .add(AppEvent.statusChanged(AppStatus.authenticated));
                  }
                },
              ),
            ],
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  _buildVideoBackground(),
                  const ColoredBox(color: Colors.black45),
                  SafeArea(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: height,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTitle(context),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // SizedBox(height: height * 0.15),
                                _buildSignInForm(context, height, width),
                                // const SizedBox(height: 70),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontSize: 8.sp),
                                    text: "pas encore de compte ? ",
                                    children: [
                                      TextSpan(
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold),
                                        text: " S'inscrire",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => context
                                              .push(PageRoutes.signUpRoute),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state.status.isInProgress) {
                        return Container(
                          decoration: BoxDecoration(
                              color: const Color(0xfff1F1F1).withOpacity(.05)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(right: 7.w, bottom: 30.h),
                                height: 25.h,
                                width: 25.h,
                                child: const CircularProgressIndicator.adaptive(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildVideoBackground() {
    return FittedBox(
      fit: BoxFit.cover,
      child: _controller.value.isInitialized
          ? SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child:
            const Image(image: AssetImage("assets/icons/swiit_logo_white.png")),
      ),
    );
  }

  bool get keyBoardIsOpen => MediaQuery.of(context).viewInsets.bottom > 0;

  Widget _buildSignInForm(BuildContext context, double height, double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        children: [
          _buildInputSection(context, height, width),
          SizedBox(height: height * 0.04),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SubmitButton(
                  title: "Se connecter",
                  onTap: () =>
                      context.read<LoginBloc>().add(LoginEvent.submit()));
            },
          ),
          if (!keyBoardIsOpen) ...[
            const SizedBox(height: 30),
            GoogleSignInButton(
              isOutlined: true,
              onTap: () {
                context.read<LoginBloc>().add(LoginEvent.loginWithGoogle());
              },
            ),
            const SizedBox(height: 10),
            FacebookSignInButton(
              isOutlined: true,
              onTap: () {
                context.read<LoginBloc>().add(LoginEvent.loginWithFacebook());
              },
            ),
            const SizedBox(height: 10),
            SizedBox(height: height * 0.01),
            TextButton(
              onPressed: () {
                print('object');
                context.push(PageRoutes.forgotPasswordRoute);
              },
              child: Text(
                "Mot de passe oublié?",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputSection(BuildContext context, double height, double width) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.black45,
      ),
      child: Column(
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) =>
                previous.email.value != current.email.value ||
                previous.password.value != current.password.value,
            builder: (context, state) {
              return FormInputText(
                  onChanged: (String value) => context
                      .read<LoginBloc>()
                      .add(LoginEvent.emailChanged(value)),
                  label: "Username, Email, Phone number",
                  labelColor: Colors.white);
            },
          ),
          SizedBox(height: height * 0.04),
          FormInputText(
            isobscureText: true,
            onChanged: (String value) => context
                .read<LoginBloc>()
                .add(LoginEvent.passwordChanged(value)),
            label: "Password",
            labelColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

Future<dynamic> ShowAlertDialogForChangeUserName(
    BuildContext context, TextEditingController newUserNameController) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Connexion réussie'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                "Vous êtes connecté avec Google. Vous voulez-vous modifier votre nom d'utilisateur ?"),
            const SizedBox(height: 20),
            FormTextField(
              title: "Username",
              controller: newUserNameController,
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                context
                        .read<AppBloc>()
                        .add(AppEvent.statusChanged(AppStatus.authenticated));
              },
              child: const Text('Continuer')),
          TextButton(
              onPressed: () {
                context.read<ProfilCubit>().updateProfile(
                    RequestParamsUpdateProfile(
                        user_name: newUserNameController.text));
                  context
                        .read<AppBloc>()
                        .add(AppEvent.statusChanged(AppStatus.authenticated));
              },
              child: const Text('Modifier')),
        ],
      );
    },
  );
}
