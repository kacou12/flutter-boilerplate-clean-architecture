import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my/core/services/router/page_routes.enum.dart';
import 'package:my/core/widgets/forms/form_input_otp.dart';
import 'package:my/features/auth/presentation/blocs/forget_password_bloc/forgot_password_bloc.dart';
import 'package:my/features/auth/presentation/blocs/forget_password_bloc/forgot_password_event.dart';
import 'package:my/features/auth/presentation/blocs/forget_password_bloc/forgot_password_state.dart';

class ForgotPasswordCodeScreen extends StatefulWidget {
  final ForgotPasswordEmailSent emailSentState;

  const ForgotPasswordCodeScreen({super.key, required this.emailSentState});

  @override
  State<ForgotPasswordCodeScreen> createState() =>
      _ForgotPasswordCodeScreenState();
}

class _ForgotPasswordCodeScreenState extends State<ForgotPasswordCodeScreen> {
  String code = '';

  final _codeController = TextEditingController();

  Widget _buildNumberPad() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              1,
              2,
              3,
            ].map((number) => _buildNumberButton(number)).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              4,
              5,
              6,
            ].map((number) => _buildNumberButton(number)).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              7,
              8,
              9,
            ].map((number) => _buildNumberButton(number)).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Container()),
              _buildNumberButton(0),
              _buildBackspaceButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(int number) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: () {
            if (code.length < 4) {
              setState(() {
                code += number.toString();
              });

              if (code.length == 4) {
                context.read<ForgotPasswordBloc>().add(
                  ForgotPasswordCodeSubmitted(code),
                );
              }
            }
          },
          child: Container(
            height: 60,
            alignment: Alignment.center,
            child: Text(
              number.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: () {
            if (code.isNotEmpty) {
              setState(() {
                code = code.substring(0, code.length - 1);
              });
            }
          },
          child: Container(
            height: 60,
            alignment: Alignment.center,
            child: const Icon(Icons.backspace, size: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: index < code.length ? Colors.blue : Colors.grey.shade300,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            index < code.length ? code[index] : '',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        );
      }),
    );
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
          'Forgot password',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordCodeVerified) {
            context.pushNamed(PageRoutes.resetPassword.name);
          } else if (state is ForgotPasswordFailure) {
            setState(() {
              code = '';
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Type your phone number',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              widget.emailSentState.email,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 32),
            const Text(
              'We texted you a code to verify your phone number',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // _buildCodeDisplay(),
            FormInputOtp(controller: _codeController),
            const Spacer(),
            // BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            //   builder: (context, state) {
            //     if (state is ForgotPasswordLoading) {
            //       return const Center(child: CircularProgressIndicator());
            //     }
            //     return _buildNumberPad();
            //   },
            // ),
            // const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
