import 'package:flutter/material.dart';
import 'package:my/features/auth/presentation/pages/onboarding.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return const OnBoardingPage();
  }
}
