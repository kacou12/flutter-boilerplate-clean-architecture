import 'package:flutter/material.dart';

class FormInputPassword extends StatelessWidget {
  FormInputPassword({required this.label, required this.labelColor, super.key});
  final String label;
  final Color labelColor;

  final ValueNotifier<bool> isHidden = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isHidden,
        builder: (context, _, widget) {
          return TextFormField(
            obscureText: isHidden.value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: labelColor),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    isHidden.value = !isHidden.value;
                  },
                  icon: Icon(isHidden.value
                      ? Icons.visibility
                      : Icons.visibility_off)),
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: labelColor),
              label: Text(label),
            ),
          );
        });
  }
}
