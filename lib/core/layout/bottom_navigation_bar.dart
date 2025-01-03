import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my/core/resources/palette.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
    required this.child,
  });

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness:
            Theme.of(context).brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
        statusBarColor: const Color(0xfff4ebf8),
      ),
      child: Scaffold(
        body: SafeArea(child: widget.child),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.child.currentIndex,
          onTap: (index) async {
            widget.child.goBranch(
              index,
              initialLocation: index == widget.child.currentIndex,
            );
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/tabs-icons/dashboard.svg',
                colorFilter: widget.child.currentIndex == 0
                    ? null
                    : const ColorFilter.mode(Palette.primary, BlendMode.srcIn),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/tabs-icons/events.svg',
                colorFilter: widget.child.currentIndex == 1
                    ? null
                    : const ColorFilter.mode(Palette.primary, BlendMode.srcIn),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/tabbar_3.svg',
                colorFilter: widget.child.currentIndex == 2
                    ? null
                    : const ColorFilter.mode(Palette.primary, BlendMode.srcIn),
                height: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/tabs-icons/map.svg',
                colorFilter: widget.child.currentIndex == 3
                    ? null
                    : const ColorFilter.mode(Palette.primary, BlendMode.srcIn),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/tabs-icons/more.svg',
                colorFilter: widget.child.currentIndex == 4
                    ? null
                    : const ColorFilter.mode(Palette.primary, BlendMode.srcIn),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
