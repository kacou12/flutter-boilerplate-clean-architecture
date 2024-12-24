import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my/core/resources/resources.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    required this.title,
    this.isOutlined = false,
    this.onTap,
    this.icon, // Icône optionnelle
    super.key,
  });

  final String title;
  final VoidCallback? onTap;
  final bool isOutlined;
  final Widget? icon; // Icône optionnelle pour le bouton

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: _decoration(),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 8), // Espace entre l'icône et le texte
            ],
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: Palette.primary,
      borderRadius: BorderRadius.circular(10),
      border: isOutlined
          ? Border.all(
              color: Colors.white,
            )
          : null,
    );
  }
}
