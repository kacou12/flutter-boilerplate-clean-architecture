import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "sectionTitle products",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              // color: const Color.fromARGB(255, 113, 113, 113)),
              color: Colors.black),
        ),
        const Text("products"),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    );
  }
}
