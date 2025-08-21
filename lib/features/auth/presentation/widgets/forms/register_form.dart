import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my/core/core.dart';
import 'package:my/core/resources/dimens.dart';
import 'package:my/core/widgets/buttons/submit_button.dart';
import 'package:my/core/widgets/forms/common_text_form_field.dart';
import 'package:my/core/widgets/my_form_builder.dart';
import 'package:my/features/auth/data/repositories/auth/auth_repository.dart';
import 'package:my/features/auth/presentation/blocs/register_cubit/register_cubit.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = context.read<RegisterCubit>().formKey;
    submitHandler() {
      if (!context.read<RegisterCubit>().formKey.currentState!.validate()) {
        "Remplissez correctement tous les champs".toToastError(context);

        return;
      }

      Map<String, dynamic> data = {};
      formKey.currentState!.instantValue;
      formKey.currentState!.fields.forEach((key, value) {
        data[key] = value.value;
      });

      context.read<RegisterCubit>().register(
        RequestParamsRegister(
          email: data['email'],
          password: data['password'],
          firstName: data['fisrtName'],
          lastName: data['lastName'],
          phone: data['phone'],
        ),
      );
    }

    return MyFormBuilder(
      formKey: context.read<RegisterCubit>().formKey,
      child: Column(
        children: [
          _LastNameInput(),
          SpacerV(value: Dimens.space12),
          _FirstNameInput(),
          SpacerV(value: Dimens.space12),
          _PhoneInput(),
          SpacerV(value: Dimens.space12),
          _EmailInput(),
          SpacerV(value: Dimens.space12),
          const _PasswordInput(),
          SpacerV(value: Dimens.space12),
          const _ConfirmPasswordInput(),
          SpacerV(value: Dimens.space12),
          SubmitButton(title: "Inscription", onTap: submitHandler),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  _EmailInput();

  final _emailPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: "email",
      validator: FormBuilderValidators.email(),
      builder: (FormFieldState field) {
        return CommonTextFormField(
          onChanged: field.didChange,
          controller: _emailPhone,
          decoration: InputDecoration(
            labelText: "Adresse email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
          ),
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  _PhoneInput();

  final _conPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: "phone",
      validator: (v) {
        return (v as String).isValidPhoneNumber();
      },
      builder: (FormFieldState field) {
        return CommonTextFormField(
          controller: _conPhone,
          onChanged: field.didChange,
          decoration: InputDecoration(
            labelText: "Numero de téléphone",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
          ),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  _LastNameInput();

  final _conLastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: "lastName",
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
      builder: (FormFieldState field) {
        return CommonTextFormField(
          controller: _conLastName,
          onChanged: field.didChange,
          decoration: InputDecoration(
            labelText: "last name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
          ),
        );
      },
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  _FirstNameInput();

  final _conFirstName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: "fisrtName",
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
      builder: (FormFieldState field) {
        return CommonTextFormField(
          onChanged: field.didChange,
          controller: _conFirstName,
          decoration: InputDecoration(
            labelText: "first name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput();

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  final conPassword = TextEditingController();

  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final IconData icon = obscureText ? Icons.visibility : Icons.visibility_off;
    return FormBuilderField(
      name: "password",
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
      builder: (FormFieldState field) {
        return CommonTextFormField(
          controller: conPassword,
          onChanged: field.didChange,
          decoration: InputDecoration(
            labelText: "Mot de passe",
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Icon(icon, color: Theme.of(context).colorScheme.primary),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatefulWidget {
  const _ConfirmPasswordInput();

  @override
  State<_ConfirmPasswordInput> createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<_ConfirmPasswordInput> {
  bool obscureText = true;

  final conPassword = TextEditingController();

  getPassordValue(BuildContext context) {
    return context
        .read<RegisterCubit>()
        .formKey
        .currentState!
        .fields
        .entries
        .firstWhere((element) => element.key == 'password')
        .value;
  }

  @override
  Widget build(BuildContext context) {
    final IconData icon = obscureText ? Icons.visibility : Icons.visibility_off;
    return FormBuilderField(
      name: "confirmPassword",
      validator: FormBuilderValidators.equal(
        getPassordValue(context),
        errorText: "Mot de passe incorrect",
      ),
      builder: (FormFieldState field) {
        return CommonTextFormField(
          controller: conPassword,
          onChanged: field.didChange,
          decoration: InputDecoration(
            labelText: "confirmation du mot de passe",
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Icon(icon, color: Theme.of(context).colorScheme.primary),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
          ),
        );
      },
    );
  }
}
