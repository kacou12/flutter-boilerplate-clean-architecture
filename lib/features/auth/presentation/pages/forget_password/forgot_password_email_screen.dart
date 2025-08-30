import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:my/core/services/router/page_routes.enum.dart';
import 'package:my/core/widgets/forms/common_text_form_field.dart';
import 'package:my/features/auth/presentation/blocs/forget_password_bloc/forgot_password_bloc.dart';
import 'package:my/features/auth/presentation/blocs/forget_password_bloc/forgot_password_event.dart';
import 'package:my/features/auth/presentation/blocs/forget_password_bloc/forgot_password_state.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final _emailController = TextEditingController(text: "test@gmail.com");

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go(PageRoutes.login.name),
        ),
        title: const Text(
          'Forgot password',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordEmailSent) {
            context.pushNamed(PageRoutes.forgotPasswordCode.name, extra: state);
          } else if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Type your phone number',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              _EmailInput(conEmail: _emailController),
              const SizedBox(height: 32),
              RichText(
                text: const TextSpan(
                  text: 'We texted you a code to verify your phone number ',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              const Spacer(),
              BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: state is ForgotPasswordLoading
                          ? null
                          : () {
                              if (_emailController.text.isNotEmpty) {
                                context.read<ForgotPasswordBloc>().add(
                                  ForgotPasswordEmailSubmitted(
                                    _emailController.text,
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C6EF5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state is ForgotPasswordLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Send',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({required this.conEmail});

  final TextEditingController conEmail;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: "email",
      initialValue: conEmail.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // validator: (v) {
      //   return (v).isValidEmailOrPhoneNumber();
      // },
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.email(
          errorText: "Veuillez saisir un email valide",
        ),
        // FormBuilderValidators.min(5, errorText: "Minimum 5 caractères"),
      ]),
      builder: (FormFieldState field) {
        return CommonTextFormField(
          onChanged: field.didChange,
          // initialValue: field.value,
          controller: conEmail,
          decoration: const InputDecoration(
            labelText: "Adresse email ou numero de téléphone",
          ),
        );
      },
    );
  }
}
