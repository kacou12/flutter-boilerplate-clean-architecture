import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:my/core/ext/context.dart';
import 'package:my/core/ext/string.dart';
import 'package:my/core/resources/dimens.dart';
import 'package:my/core/resources/images.dart';
import 'package:my/core/services/router/page_routes.enum.dart';
import 'package:my/core/widgets/buttons/submit_button.dart';
import 'package:my/core/widgets/forms/common_text_form_field.dart';
import 'package:my/core/widgets/my_form_builder.dart';
import 'package:my/features/auth/data/repositories/auth/auth_repository.dart';
import 'package:my/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:my/features/auth/presentation/blocs/login_cubit/login_cubit.dart';

import '../../../../core/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Controller
  final _conEmail = TextEditingController(text: "abc");
  final _conPassword = TextEditingController(text: "testtest");

  LoginCubit get cubit {
    return context.read<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (_, state) {
            switch (state) {
              case LoginLoading():
                context.show();
                break;
              case LoginFailure(message: String message):
                context.dismiss();
                message.toToastError(context);
                break;
              case LoginSuccess():
                context
                    .read<AuthBloc>()
                    .add(const AuthStatusChanged(AuthStatus.authenticated));

              default:
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isAuthenticated) {
              context.dismiss();
              context.goNamed(PageRoutes.userHome.name);
            }
          },
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimens.space24),
            child: AutofillGroup(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.icLauncher,
                    width: context.widthInPercent(70),
                  ),
                  SpacerV(value: Dimens.space50),
                  _loginForm(),
                  ButtonText(
                    title: "Register",
                    onPressed: () {
                      // TODO : implement register
                      context.pushNamed(PageRoutes.register.name);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() => BlocBuilder<LoginCubit, LoginState>(
        builder: (_, __) {
          return MyFormBuilder(
            formKey: cubit.formKey,
            child: Column(
              children: [
                _UsernameInput(conEmail: _conEmail),
                SpacerV(value: Dimens.space24),
                _PasswordInput(conPassword: _conPassword),
                SpacerV(value: Dimens.space24),
                SubmitButton(
                  title: "login",
                  onTap: () {
                    if (cubit.formKey.currentState!.validate()) {
                      context.read<LoginCubit>().login(
                            RequestParamsLogin(
                              email: _conEmail.text,
                              password: _conPassword.text,
                            ),
                          );
                    } else {
                      final errors = cubit.formKey.currentState!.fields
                          .map((key, field) => MapEntry(key, field.errorText))
                          .entries
                          .where((entry) => entry.value != null)
                          .map((entry) => '${entry.key}: ${entry.value}')
                          .toList();

                      errors.join("\n").toToastError(context);
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({required this.conEmail});

  final TextEditingController conEmail;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: "username",
        initialValue: conEmail.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // validator: (v) {
        //   return (v).isValidEmailOrPhoneNumber();
        // },
        builder: (FormFieldState field) {
          return CommonTextFormField(
              onChanged: field.didChange,
              // initialValue: field.value,
              controller: conEmail,
              decoration: const InputDecoration(
                labelText: "Adresse email ou numero de téléphone",
              ));
        });
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput({required this.conPassword});

  final TextEditingController conPassword;

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final IconData icon = obscureText ? Icons.visibility : Icons.visibility_off;
    return FormBuilderField(
        name: "password",
        initialValue: widget.conPassword.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
              errorText: "Veuillez remplir ce champ"),
          // FormBuilderValidators.min(5, errorText: "Minimum 5 caractères"),
        ]),
        builder: (FormFieldState field) {
          return CommonTextFormField(
            onChanged: field.didChange,
            controller: widget.conPassword,
            decoration: InputDecoration(
                labelText: "Mot de passe",
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                )),
          );
        });
  }
}
