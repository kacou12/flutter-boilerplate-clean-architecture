import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MyFormBuilder extends StatelessWidget {
  final Widget child;
  final GlobalKey<FormBuilderState> formKey;
  const MyFormBuilder({super.key, required this.formKey, required this.child});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: child);
  }
}
