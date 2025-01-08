import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class UsersProfilScreen extends StatelessWidget {
  const UsersProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "user profil page",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      // color: const Color.fromARGB(255, 113, 113, 113)),
                      color: Colors.black),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
