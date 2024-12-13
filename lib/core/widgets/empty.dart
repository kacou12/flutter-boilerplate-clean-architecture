import 'package:flutter/material.dart';
import 'package:my/core/resources/resources.dart';
import 'package:my/core/core.dart';

class Empty extends StatelessWidget {
  final String errorMessage;

  const Empty({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Images.icLauncher,
          width: context.widthInPercent(45),
        ),
        Text(
          errorMessage,
        ),
      ],
    );
  }
}
