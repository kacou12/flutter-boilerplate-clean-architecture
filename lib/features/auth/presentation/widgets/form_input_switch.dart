import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class FormInputSwitch extends StatelessWidget {
  const FormInputSwitch(
      {required this.label,
      required this.labelColor,
       this.onChanged,
      super.key,
      required this.isSelected,
      required this.onTap});
  final String label;
  final Color labelColor;
  final bool isSelected;
  final VoidCallback onTap;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      //enabled: isSelected,
      onChanged: onChanged,
      style:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: labelColor),
      decoration: InputDecoration(
        // constraints: const BoxConstraints(
        //     maxHeight: 30
        // ),
        suffixIcon: GestureDetector(
          child: _buildSuffixIcon(),
        ),
        labelStyle:
            Theme.of(context).textTheme.bodyMedium?.copyWith(color: labelColor),
        label: Text(label),
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return FittedBox(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: Colors.black45)),
        child: Container(
          alignment: Alignment.center,
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isSelected ? AppColors.colorGradient : null,
            color: isSelected ? null : Colors.blueGrey,
          ),
          child: isSelected
              ? const FittedBox(
                  child: Icon(
                  Icons.check,
                  color: Colors.white,
                ))
              : null,
        ),
      ),
    );
  }
}
