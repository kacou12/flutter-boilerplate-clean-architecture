import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiit/src/core/constants/app_colors.dart';
import 'package:swiit/src/core/core.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:swiit/src/core/country_code/country_code_list.dart';
import 'package:swiit/src/core/country_code/country_codes.dart';
import 'package:swiit/src/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:swiit/src/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:swiit/src/features/auth/presentation/bloc/forgot_password/forgot_password_event.dart';
import 'package:swiit/src/features/auth/presentation/bloc/forgot_password/forgot_password_state.dart';

enum FormInputType {
  signIn,
  forgotPassword,
  register,
}

class FormInputText extends StatefulWidget {
  const FormInputText(
      {required this.label,
      required this.labelColor,
      required this.onChanged,
      this.isobscureText = false,
      super.key});
  final String label;
  final Color labelColor;
  final void Function(String)? onChanged;
  final bool isobscureText;

  @override
  State<FormInputText> createState() => _FormInputTextState();
}

class _FormInputTextState extends State<FormInputText> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      obscureText: widget.isobscureText && _passwordVisible,
      style: GoogleFonts.poppins(color: widget.labelColor, fontSize: 14.sp),
      decoration: InputDecoration(
        suffixIcon: widget.isobscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                icon: Icon(
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ))
            : const SizedBox(),
        labelStyle:
            GoogleFonts.poppins(color: widget.labelColor, fontSize: 13.sp),
        label: Text(widget.label),
      ),
    );
  }
}

class FormInputTel extends StatefulWidget {
  const FormInputTel(
      {required this.label,
      required this.placeholder,
      required this.labelColor,
      required this.onChanged,
      required this.type,
      super.key});

  final String label;
  final String placeholder;
  final Color labelColor;
  final FormInputType type;

  final void Function(String)? onChanged;

  @override
  State<FormInputTel> createState() => _FormInputTelState();
}

class _FormInputTelState extends State<FormInputTel> {
  String currentContryCode = "FR";
  TextEditingController phoneController = TextEditingController();

  late CountryCode countryData;

  @override
  void initState() {
    countryData = CountryCode.fromCountryCode(currentContryCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(
              fontSize: 11.sp,
              color: Colors.grey.withOpacity(.8),
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(.5))),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 60.w),
                child: TextFormField(
                  controller: phoneController,
                  onChanged: (String? value) {
                    widget.onChanged!(
                        '${countryData.dialCode}${value?.split(" ")}');
                    // widget.onChanged!('$value');
                  },
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: countryData.mask,
                      filter: {"#": RegExp(r'[0-9]')},
                      // type: MaskAutoCompletionType.lazy
                    )
                  ],
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.poppins(
                      color: widget.labelColor, fontSize: 9.sp),
                  decoration: InputDecoration(
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(14.r),
                    filled: true,
                    border: InputBorder.none,
                    suffixIcon: widget.type == FormInputType.forgotPassword
                        ? BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                            builder: (context, state) {
                              return Container(
                                margin: EdgeInsets.all(12.r),
                                child: CircularCheckbox(
                                  value: state.type == TypeRecoveryPassword.tel,
                                  onChanged: (value) {
                                    context.read<ForgotPasswordBloc>().add(
                                        ForgotPasswordEvent.typeChanged(
                                            TypeRecoveryPassword.tel));
                                    // _toggleCheckbox();
                                  },
                                ),
                              );
                            },
                          )
                        : null,

                    errorText: null,

                    hintStyle: GoogleFonts.poppins(
                        color: Colors.grey.withOpacity(.8),
                        fontWeight: FontWeight.w800,
                        fontSize: 10.sp),
                    hintText: widget.placeholder,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () async {
                      final selectedOption = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CountryCodeListOptions(
                              title: widget.label,
                              selectedOption: countryData,
                              options: codes
                                  .map((x) => CountryCode.fromJson(x))
                                  .toList(),
                            ),
                          ));
                      if (selectedOption != null &&
                          selectedOption != countryData) {
                        // isValid = true;
                        phoneController.text = "";
                        widget.onChanged!('');

                        countryData = CountryCode.fromCountryCode(
                            (selectedOption as CountryCode).code!);
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(3.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            right: BorderSide(
                                color: Colors.grey.withOpacity(.5), width: 1)),
                      ),
                      height: 40.h,
                      width: 60.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          countryData.flagUri ?? const SizedBox(),
                          SizedBox(
                            width: 6.w,
                          ),
                          Center(
                            child: Text(
                              '${countryData.dialCode}',
                              style: GoogleFonts.poppins(
                                  fontSize: 8.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              // Positioned(
              //   top: 10,
              //   bottom: 10,
              //   right: 5,
              //   // alignment: Alignment.centerRight,
              //   child: CircleAvatar(
              //       radius: 10,
              //       child: Icon(
              //         Icons.check,
              //         size: 10.w,
              //       )),
              // )
            ],
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    );
  }
}

class FormInputRegisterText extends StatefulWidget {
  const FormInputRegisterText(
      {required this.label,
      required this.placeholder,
      required this.onChanged,
      required this.labelColor,
      required this.type,
      this.isobscureText = false,
      super.key});
  final String label;
  final String placeholder;
  final Color labelColor;
  final bool isobscureText;

  final FormInputType type;
  final void Function(String)? onChanged;

  @override
  State<FormInputRegisterText> createState() => _FormInputRegisterTextState();
}

class _FormInputRegisterTextState extends State<FormInputRegisterText> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(
              fontSize: 11.sp,
              color: Colors.grey.withOpacity(.8),
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          onChanged: widget.onChanged,
          obscureText: widget.isobscureText && _passwordVisible,
          style: GoogleFonts.poppins(
              color: Colors.grey, fontSize: 9.sp, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(14.r),
            filled: true,
            suffixIcon: widget.type == FormInputType.forgotPassword
                ? BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    builder: (context, state) {
                      return Container(
                        margin: EdgeInsets.all(12.r),
                        child: CircularCheckbox(
                          value: state.type == TypeRecoveryPassword.email,
                          onChanged: (value) {
                            context.read<ForgotPasswordBloc>().add(
                                ForgotPasswordEvent.typeChanged(
                                    TypeRecoveryPassword.email));
                            // _toggleCheckbox();
                          },
                        ),
                      );
                    },
                  )
                : (widget.isobscureText)
                    ? widget.isobscureText
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ))
                        : const SizedBox()
                    : null,

            errorText: null,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(.5)),
                borderRadius: BorderRadius.circular(4.r)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(4.r)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(.5)),
                gapPadding: 2.0,
                borderRadius: BorderRadius.circular(4.r)),
            border: OutlineInputBorder(
                gapPadding: 2.0, borderRadius: BorderRadius.circular(3)),
            errorStyle:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            hintStyle: GoogleFonts.poppins(
                color: Colors.grey.withOpacity(.8),
                fontWeight: FontWeight.w800,
                fontSize: 10.sp),
            hintText: widget.placeholder,
            fillColor: Colors.white,
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    );
  }
}

class CircularCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CircularCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: value ? Colors.blue : Colors.grey,
            width: 2,
          ),
          color: value ? Colors.blue : Colors.transparent,
        ),
        child: value
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 10,
              )
            : null,
      ),
    );
  }
}

class CountryCodeListOptions extends StatefulWidget {
  final String title;
  final List<CountryCode> options;
  final CountryCode? selectedOption;

  const CountryCodeListOptions(
      {super.key,
      required this.title,
      required this.options,
      this.selectedOption});

  @override
  _CountryCodeListOptionsState createState() => _CountryCodeListOptionsState();
}

class _CountryCodeListOptionsState extends State<CountryCodeListOptions> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CountryCode? _selectedOption;
  String _searchQuery = '';

  @override
  void initState() {
    _selectedOption = widget.selectedOption;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CountryCode> filteredOptions = widget.options
        .where((option) =>
            option.name
                .getOrEmpty()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            option.dialCode.getOrEmpty().contains(_searchQuery))
        .toList();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xfff4f4f4),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
              decoration: const BoxDecoration(color: Colors.white),
              height: 55.h,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          size: 20.h,
                          color: Colors.grey,
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.all(12.r),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white.withOpacity(.5)),
                            borderRadius: BorderRadius.circular(4.r)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(4.r)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white.withOpacity(.5)),
                            gapPadding: 2.0,
                            borderRadius: BorderRadius.circular(4.r)),
                        border: OutlineInputBorder(
                            gapPadding: 2.0,
                            borderRadius: BorderRadius.circular(3)),
                        errorStyle: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey.withOpacity(.8),
                            fontWeight: FontWeight.w800,
                            fontSize: 10.sp),
                        hintText: 'Rechercher ici',
                        fillColor: const Color(0xfff1f1f1),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: _sendSelectedOption,
                    child: Text(
                      'Annuler',
                      style: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            Expanded(
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        for (CountryCode option in filteredOptions)
                          _buildOption(option)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(CountryCode option) {
    return Builder(builder: (context) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        child: GestureDetector(
          onTap: () => _selectOption(context, option),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            margin: EdgeInsets.only(bottom: 10.h, left: 7.w, right: 7.w),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.07),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(7.r),
                border: const Border(
                    bottom: BorderSide(color: AppColors.lightViolet))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  option.flagUri ?? const SizedBox(),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Text(
                      option.name.getOrEmpty(),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontSize: 10.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    option.dialCode.getOrEmpty(),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 10.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _sendSelectedOption() {
    if (_selectedOption != null) {
      Navigator.pop(context, _selectedOption);
    } else {
      Navigator.pop(context, _selectedOption);
    }
  }

  void _selectOption(BuildContext context, CountryCode option) async {
    setState(() {
      _selectedOption = option;
    });
    Navigator.pop(context, _selectedOption);
  }
}
