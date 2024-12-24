import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormField extends StatelessWidget {
  // final String name;
  final InputDecoration? decoration;
  // final String? initialValue;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final int maxLines, minLines;
  final int? maxLength;
  final bool? readOnly;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String?)? onSubmitted;
  final EdgeInsets? scrollPadding;
  const CommonTextFormField(
      {super.key,
      // required this.name,
      this.decoration,
      this.readOnly,
      this.onTap,
      // this.initialValue,
      required this.onChanged,
      this.validator,
      this.obscureText = false,
      this.keyboardType,
      this.maxLines = 1,
      this.maxLength,
      this.minLines = 1,
      this.controller,
      this.enabled,
      this.inputFormatters,
      this.scrollPadding,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType,
        // initialValue: initialValue,
        // validator: validator,
        obscureText: obscureText,
        onChanged: onChanged,
        minLines: minLines,
        onTap: onTap,
        maxLines: maxLines,
        enabled: enabled ?? true,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
        decoration: _inputDecoration);
  }

  InputDecoration get _inputDecoration {
    if (decoration is InputDecoration) {
      return decoration!.copyWith(border: _border);
    }

    return InputDecoration(border: _border);
  }

  InputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    );
  }
}
