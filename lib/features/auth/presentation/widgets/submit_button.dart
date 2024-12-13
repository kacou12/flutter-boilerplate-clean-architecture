import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Pour utiliser des icônes SVG

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    required this.title,
    this.isOutlined = false,
    required this.onTap,
    this.icon, // Icône optionnelle
    super.key,
  });

  final String title;
  final VoidCallback onTap;
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
              SizedBox(width: 8), // Espace entre l'icône et le texte
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
      gradient: isOutlined
          ? null
          : const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Color(0xFF5a62a8), Color(0xFFa555a1)]),
      borderRadius: BorderRadius.circular(5),
      border: isOutlined
          ? Border.all(
              color: Colors.white,
            )
          : null,
    );
  }
}

// Bouton Google
class GoogleSignInButton extends StatelessWidget {
  final bool isOutlined;
  final VoidCallback onTap;
  final String? label;

  const GoogleSignInButton({super.key, required this.onTap, this.isOutlined = false, this.label});

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      title: label ?? 'Se connecter avec Google',
      onTap: onTap,
      icon: SvgPicture.asset(
        'assets/icons/icon-google.svg', // Ajoute une icône Google (SVG ou PNG)
        height: 24,
        width: 24,
      ),
      isOutlined: isOutlined, // Peut être outlined ou pas selon le style voulu
    );
  }
}

// Bouton Facebook
class FacebookSignInButton extends StatelessWidget {
  final bool isOutlined;
  final String? label;
  final VoidCallback onTap;

  const FacebookSignInButton({super.key, required this.onTap, this.isOutlined = false, this.label});

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      title: label ?? 'Se connecter avec Facebook' ,
      onTap: onTap,
      icon: SvgPicture.asset(
        'assets/icons/icon-facebook.svg', // Ajoute une icône Facebook (SVG ou PNG)
        height: 24,
        width: 24,
      ),
      isOutlined: isOutlined, // Peut aussi être outlined
    );
  }
}
