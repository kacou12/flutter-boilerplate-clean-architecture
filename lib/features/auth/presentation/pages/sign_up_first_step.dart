import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiit/src/core/model/api/api_state.dart';
import 'package:swiit/src/core/reusable/form_input/checkbox_input.dart';
import 'package:swiit/src/core/reusable/form_input/dropdown_menu.dart';
import 'package:swiit/src/core/reusable/form_input/form_input.dart';
import 'package:swiit/src/features/API/api-gblobal/domain/entities/entity.dart';
import 'package:swiit/src/features/auth/presentation/bloc/bloc.dart';
import 'package:swiit/src/features/auth/presentation/bloc/country_bloc/country_bloc.dart';
import 'package:swiit/src/features/auth/presentation/pages/sign_in.dart';

import '../../../clubs/presentation/cubit/club_state.dart';
import '../cubit/city_cubit.dart';
import '../cubit/city_state.dart';
import '../widgets/form_input_text.dart';
import '../widgets/submit_button.dart';

class SignUpFirstStep extends StatelessWidget {
  const SignUpFirstStep({super.key, this.onNext});
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              context
                  .read<RegisterBloc>()
                  .add(RegisterEvent.usernameChanged(state.username.value));
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
              onNext?.call();
            }
          },
        ),
        BlocListener<LoginBloc, LoginState>(listener: (context, state) {
          if (state.status.isSuccess && state.socialConnected == true) {
            // show dialog for change username
            final TextEditingController newUserNameController =
                TextEditingController(text: state.userName ?? "");
            ShowAlertDialogForChangeUserName(context, newUserNameController);
          }
        })
      ],
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 130,
                  child:
                      Image(image: AssetImage("assets/icons/swiit_logo.png")),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Rejoignez la communauté des swiiters'.toUpperCase(),
                  style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                GoogleSignInButton(
                  isOutlined: false,
                  label: "S'inscrire avec Google",
                  onTap: () {
                    context.read<LoginBloc>().add(LoginEvent.loginWithGoogle());
                  },
                ),
                const SizedBox(height: 10),
                FacebookSignInButton(
                  label: "S'inscrire avec Facebook",
                  onTap: () {
                    context
                        .read<LoginBloc>()
                        .add(const LoginEvent.loginWithFacebook());
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            BlocBuilder<RegisterBloc, RegisterState>(
              buildWhen: (previous, current) =>
                  previous.fullName.value != current.fullName.value,
              builder: (context, state) {
                return FormInputRegisterText(
                  type: FormInputType.signIn,
                  onChanged: (String value) => context
                      .read<RegisterBloc>()
                      .add(RegisterEvent.fullNameChanged(value)),
                  label: "Nom complet",
                  labelColor: const Color(0xFFBBBDBF),
                  placeholder: 'Entrer votre nom complet',
                );
              },
            ),
            BlocBuilder<RegisterBloc, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.username.value != current.username.value,
                builder: (context, state) {
                  return FormInputRegisterText(
                    type: FormInputType.signIn,
                    onChanged: (String value) => context
                        .read<RegisterBloc>()
                        .add(RegisterEvent.usernameChanged(value)),
                    label: "Nom d'utilisateur",
                    labelColor: const Color(0xFFBBBDBF),
                    placeholder: 'Entrer le nom d\'utilisateur',
                  );
                }),
            BlocBuilder<RegisterBloc, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.email.value != current.email.value,
                builder: (context, state) {
                  return FormInputRegisterText(
                    type: FormInputType.signIn,
                    onChanged: (String value) => context
                        .read<RegisterBloc>()
                        .add(RegisterEvent.emailChanged(value)),
                    label: "Adresse e-mail",
                    labelColor: const Color(0xFFBBBDBF),
                    placeholder: 'Entrer l\'adresse email',
                  );
                }),
            // BlocBuilder<RegisterBloc, RegisterState>(
            //     buildWhen: (previous, current) =>
            //         previous.telephone.value != current.telephone.value,
            //     builder: (context, state) {
            //       return FormInputTel(
            //         type: FormInputType.signIn,
            //         onChanged: (String value) => context
            //             .read<RegisterBloc>()
            //             .add(RegisterEvent.telephoneChanged(value)),
            //         label: "Numéro de téléphone",
            //         labelColor: const Color(0xFFBBBDBF),
            //         placeholder: 'xxxxxxxxxx',
            //       );
            //     }),
            FormInputTel(
              type: FormInputType.signIn,
              onChanged: (String value) => context
                  .read<RegisterBloc>()
                  .add(RegisterEvent.telephoneChanged(value)),
              label: "Numéro de téléphone",
              labelColor: const Color(0xFFBBBDBF),
              placeholder: 'xxxxxxxxxx',
            ),
            BlocBuilder<RegisterBloc, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.password.value != current.password.value,
                builder: (context, state) {
                  return FormInputRegisterText(
                    type: FormInputType.signIn,
                    isobscureText: true,
                    onChanged: (String value) => context
                        .read<RegisterBloc>()
                        .add(RegisterEvent.passwordChanged(value)),
                    label: "Mot de passe",
                    labelColor: const Color(0xFFBBBDBF),
                    placeholder: 'Entrer le mot de passe',
                  );
                }),
            BlocBuilder<RegisterBloc, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.confirmPassword.value !=
                    current.confirmPassword.value,
                builder: (context, state) {
                  return FormInputRegisterText(
                    isobscureText: true,
                    type: FormInputType.signIn,
                    onChanged: (String value) => context
                        .read<RegisterBloc>()
                        .add(RegisterEvent.confirmPasswordChanged(value)),
                    label: "Confirmer votre mot de passe",
                    labelColor: const Color(0xFFBBBDBF),
                    placeholder: 'Confirmer votre mot de passe',
                  );
                }),
            SizedBox(
              height: 70.h,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pays',
                          style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: Colors.grey.withOpacity(.8),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Expanded(
                          child:
                              BlocBuilder<CountryBloc, ApiState<List<Country>>>(
                            builder: (context, state) {
                              if (state is SuccessState<List<Country>>) {
                                return AppDropdownMenu(
                                  key: ValueKey(FormKeys.country),
                                  label: 'Pays',
                                  options: [
                                    'Selctionner',
                                    ...state.data.map((x) => x.name)
                                  ],
                                  defaultOption: 'Selctionner',
                                  onValidate: (String key, bool isValid,
                                      {String? value}) {
                                    if (isValid && value != null) {
                                      context.read<RegisterBloc>().add(
                                          RegisterEvent.paysChanged(value));
                                      context
                                          .read<CityCubit>()
                                          .getCities(value);
                                    }
                                  },
                                );
                              }
                              return AppDropdownMenu(
                                key: ValueKey(FormKeys.country),
                                label: 'Pays',
                                options: const ['Selctionner', '2', '3'],
                                defaultOption: 'Selctionner',
                                onValidate: (String key, bool isValid,
                                    {String? value}) {},
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: height * 0.02,
                  ),
                  Expanded(
                    child: //Country selector
                        Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ville',
                          style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: Colors.grey.withOpacity(.8),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        BlocBuilder<CityCubit, CityState>(
                          builder: (context, state) {
                            if (state.citesStatus == Status.success &&
                                state.cites.isNotEmpty) {
                              return AppDropdownMenu(
                                key: ValueKey(FormKeys.city),
                                label: 'Ville',
                                options: [
                                  'Selctionner',
                                  ...state.cites.map((x) => x.name)
                                ],
                                defaultOption: 'Selctionner',
                                onValidate: (String key, bool isValid,
                                    {String? value}) {
                                  if (isValid && value != null) {
                                    context
                                        .read<RegisterBloc>()
                                        .add(RegisterEvent.villeChanged(value));
                                  }
                                },
                              );
                            }
                            return AppDropdownMenu(
                              key: ValueKey(FormKeys.country),
                              label: 'Ville',
                              options: const [],
                              defaultOption: 'Aucune ville',
                              onValidate: (String key, bool isValid,
                                  {String? value}) {
                                context
                                    .read<RegisterBloc>()
                                    .add(RegisterEvent.villeChanged('Paris'));
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    // child: TextFormField(
                    //   style: GoogleFonts.poppins(
                    //       color: const Color(0xFFBBBDBF), fontSize: 9.sp),
                    //   decoration:
                    //       getInputDecoration(msgError: '', placeholder: 'Ville'),
                    // ),
                    // child: TextFormField(
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .bodyMedium
                    //       ?.copyWith(color: const Color(0xFFBBBDBF)),
                    //   decoration: InputDecoration(
                    //     suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    //     labelStyle: Theme.of(context)
                    //         .textTheme
                    //         .bodyMedium
                    //         ?.copyWith(color: const Color(0xFFBBBDBF)),
                    //     label: const Text("City"),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            BlocBuilder<RegisterBloc, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.codeParrainage.value !=
                    current.codeParrainage.value,
                builder: (context, state) {
                  return FormInputRegisterText(
                    type: FormInputType.signIn,
                    onChanged: (String value) => context
                        .read<RegisterBloc>()
                        .add(RegisterEvent.codeParrainageChanged(value)),
                    label: "Code de parrainage (facultatif)",
                    labelColor: const Color(0xFFBBBDBF),
                    placeholder: 'Code de votre parrain',
                  );
                }),
            BlocBuilder<RegisterBloc, RegisterState>(
              buildWhen: (previous, current) =>
                  previous.isApproved != current.isApproved,
              builder: (context, state) {
                print('state :: ${state.isApproved}');
                return CheckBoxInput(
                    isActive: state.isApproved,
                    onChange: (value) => context.read<RegisterBloc>().add(
                        RegisterEvent.acceptePolitiqueChanged(value ?? false)),
                    label:
                        'J\'accepte les CGV et la politique de confidentialité');
              },
            ),
            BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
              return SubmitButton(
                  title: "S'inscrire",
                  onTap: () {
                    context.read<RegisterBloc>().add(RegisterEvent.submit());
                  });
            }),
            SizedBox(
              height: height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
