import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my/core/ext/context.dart';
import 'package:my/core/ext/string.dart';
import 'package:my/core/resources/dimens.dart';
import 'package:my/core/resources/images.dart';
import 'package:my/core/widgets/forms/common_text_form_field.dart';
import 'package:my/core/widgets/my_form_builder.dart';
import 'package:my/features/auth/domain/repositories/auth_repository.dart';
import 'package:my/features/auth/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:my/core/widgets/buttons/submit_button.dart';

import '../../../../core/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Controller
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  LoginCubit get cubit {
    return context.read<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (_, state) {
        switch (state) {
          case LoginLoading():
            context.show();
            break;
          case LoginFailure(message: String message):
            context.dismiss();
            message.toToastError(context);
            break;

          default:
        }
      },
      child: Center(
        child: SingleChildScrollView(
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
                      // context.pushNamed(Routes.register.name);
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
                // TextFormField()
                _UsernameInput(conEmail: _conEmail),
                SpacerV(value: Dimens.space24),
                _PasswordInput(conPassword: _conPassword),

                SubmitButton(
                  title: "login",
                  onTap: () {
                    cubit.formKey.currentState!.validate()
                        ? () => context.read<LoginCubit>().login(
                              RequestParamsLogin(
                                email: _conEmail.text,
                                password: _conPassword.text,
                              ),
                            )
                        : null;
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
        name: "email or phone number",
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
        builder: (FormFieldState field) {
          return CommonTextFormField(
              name: "login",
              validator: (v) {
                return v.isValidEmailOrPhoneNumber();
              },
              controller: conEmail,
              decoration: InputDecoration(
                  labelText: "Adresse email ou numero de téléphone",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  )));
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
  final password = TextEditingController();

  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final IconData icon = obscureText ? Icons.visibility : Icons.visibility_off;
    return FormBuilderField(
        name: "email or phone number",
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
        builder: (FormFieldState field) {
          return CommonTextFormField(
            validator: FormBuilderValidators.required(),
            name: "password",
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
