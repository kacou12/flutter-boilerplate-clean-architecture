import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiit/src/features/auth/presentation/bloc/bloc.dart';
import 'package:swiit/src/features/auth/presentation/widgets/form_input_switch.dart';
import 'package:swiit/src/features/auth/presentation/widgets/submit_button.dart';

import '../bloc/register/register_bloc.dart';
import '../bloc/register/register_event.dart';

enum FormInputState { number, email }

class SignUpSecondStep extends StatefulWidget {
  const SignUpSecondStep({
    super.key,
    required this.onNext,
    this.pageController,
  });
  final VoidCallback onNext;
  final PageController? pageController;

  @override
  State<SignUpSecondStep> createState() => _SignUpSecondStepState();
}

class _SignUpSecondStepState extends State<SignUpSecondStep> {
  var stateSelected = FormInputState.number;
  void _setNumberField() {
    setState(() {
      stateSelected = FormInputState.number;
    });
  }

  void _setEmailField() {
    setState(() {
      stateSelected = FormInputState.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Account verification",
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
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    FormInputSwitch(
                      label: "Number",
                      labelColor: const Color(0xFFBBBDBF),
                      isSelected: stateSelected == FormInputState.number,
                      onTap: _setNumberField,
                      onChanged: (value) {
                        context
                            .read<RegisterBloc>()
                            .add(RegisterEvent.telephoneChanged(value));
                      },
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    FormInputSwitch(
                      label: "Email",
                      labelColor: const Color(0xFFBBBDBF),
                      isSelected: stateSelected == FormInputState.email,
                      onTap: _setEmailField,
                      onChanged: (value) {
                        context
                            .read<RegisterBloc>()
                            .add(RegisterEvent.emailChanged(value));
                      },
                    ),
                  ],
                ),
              ),
              SubmitButton(
                  title: "Get the code",
                  onTap: () {
                    final email = context.read<LoginBloc>().state.email.value;
                    if (stateSelected == FormInputState.number) {
                      context.read<RegisterBloc>().add(
                          RegisterEvent.verifyEmail(
                              context
                                  .read<RegisterBloc>()
                                  .state
                                  .telephone
                                  .value,
                              email));
                      return;
                    }
                    if (stateSelected == FormInputState.email) {
                      context.read<RegisterBloc>().add(
                          RegisterEvent.verifyEmail(
                              context.read<RegisterBloc>().state.email.value,
                              email));
                      return;
                    }
                  })
            ],
          ),
        ),
      ],
    );
  }
}
