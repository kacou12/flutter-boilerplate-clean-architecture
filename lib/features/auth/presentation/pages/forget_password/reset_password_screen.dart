import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my/core/services/router/page_routes.enum.dart';

import 'package:my/features/auth/presentation/blocs/forget_password_bloc/forgot_password_bloc.dart';
import 'package:my/features/auth/presentation/blocs/forget_password_bloc/forgot_password_event.dart';
import 'package:my/features/auth/presentation/blocs/forget_password_bloc/forgot_password_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Change password',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            context.pushNamed(PageRoutes.successResetPassword.name);
          } else if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Type your new password',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _newPasswordController,
                obscureText: _obscureNew,
                decoration: InputDecoration(
                  hintText: 'New password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNew ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(() => _obscureNew = !_obscureNew),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  hintText: 'Confirm password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const Spacer(),
              BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: state is ForgotPasswordLoading
                          ? null
                          : () {
                              if (_newPasswordController.text.isNotEmpty &&
                                  _confirmPasswordController.text.isNotEmpty) {
                                context.read<ForgotPasswordBloc>().add(
                                  NewPasswordSubmitted(
                                    _newPasswordController.text,
                                    _confirmPasswordController.text,
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C6EF5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state is ForgotPasswordLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Change password',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
