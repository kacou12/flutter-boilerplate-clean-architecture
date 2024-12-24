import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my/core/resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my/core/services/router/page_routes.enum.dart';

import 'package:my/core/widgets/buttons/submit_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:my/core/ext/context.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  void _showCupertinoDialog(BuildContext context) {
    showDialog(
      context: context,
      // barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Image.asset(
            Images.icLauncher,
            height: 20.h,
          ),
          content: SizedBox(
            child: Text('Êtes-vous sûr de vouloir vous deconnecter?',
                style: GoogleFonts.poppins(
                    color: Colors.black, fontWeight: FontWeight.w500)),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Non',
                  style: GoogleFonts.poppins(
                      color: Colors.blue, fontWeight: FontWeight.w500)),
            ),
            CupertinoDialogAction(
              onPressed: () {
                context.show();
                context.read<AuthBloc>().add(AuthLogoutRequest());
              },
              child: Text(
                'Oui',
                style: GoogleFonts.poppins(
                    color: Colors.red, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isUnauthenticated) {
            context.dismiss();
            while (context.canPop()) {
              context.pop();
            }

            return context.pushReplacement(PageRoutes.login.path);
          }
        },
        child: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "sectionTitle",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        // color: const Color.fromARGB(255, 113, 113, 113)),
                        color: Colors.black),
                  ),
                  Text(state.user?.name ?? "loading"),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SubmitButton(
                    title: "Loggout",
                    onTap: () {
                      _showCupertinoDialog(context);
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
