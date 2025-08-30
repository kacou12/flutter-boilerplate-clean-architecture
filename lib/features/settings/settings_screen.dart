import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "sectionTitle settings",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              // color: const Color.fromARGB(255, 113, 113, 113)),
              color: Colors.black),
        ),
        const Text("settings"),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    );
  }
}
