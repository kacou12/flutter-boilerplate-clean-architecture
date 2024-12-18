import 'package:flutter/material.dart';
import 'package:my/features/auth/presentation/pages/onboarding_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return const OnBoardingScreen();
  }
}
