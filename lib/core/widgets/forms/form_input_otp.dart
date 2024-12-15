import 'package:flutter/material.dart';

class FormInputOtp extends StatelessWidget {
  const FormInputOtp({super.key, this.controller});

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
        if (value.isEmpty) {
          FocusScope.of(context).previousFocus();
        }
      },
      controller: controller,
      maxLength: 1,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: const Color(0xFFBBBDBF)),
      decoration: InputDecoration(
        counterText: '',
        labelStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: const Color(0xFFBBBDBF)),
      ),
    );
  }
}
