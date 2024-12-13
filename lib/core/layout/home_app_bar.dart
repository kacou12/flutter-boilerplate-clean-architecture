import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            // context.push(PageRoute.searchRoute);
          },
          icon: const Icon(
            Icons.search,
            // color: AppColors.gray,
          ),
        ),
        IconButton(
          onPressed: () {
            // context.push(PageRoute.chatRoute);
          },
          icon: const Icon(
            Icons.mail,
            // color: AppColors.gray
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
