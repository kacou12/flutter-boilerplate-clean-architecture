import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({
    super.key,
    required this.child,
    this.title,
  });

  final Widget child;
  final String? title;

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> isSheetVisible = ValueNotifier<bool>(false);
  late AnimationController animationController;
  late Animation<double> animation;
  final double minChildSize = 0.0;
  double currentExtent = 0.2;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
  }

  void toggleSheetVisibility() {
    if (animationController.isDismissed) {
      isSheetVisible.value = !isSheetVisible.value;
      animationController.forward();
    } else {
      animationController.reverse();
      Future.delayed(const Duration(milliseconds: 300), () {
        isSheetVisible.value = !isSheetVisible.value;
      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // purple: profil
    //whiet: feed, setting

    final routePath = GoRouter.of(context).routeInformationProvider.value.uri;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(42.h),
        child: AppBar(
          leading: Center(
            child: Builder(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // IconButton(
                  //   icon: const Icon(
                  //     Icons.favorite,
                  //     color: Colors.white,
                  //     size: 24,
                  //   ),
                  //   onPressed: () {},
                  // ),
                  IconButton(
                    onPressed: () {
                      // context.push(PageRoutes.notifications);
                    },
                    icon: Icon(
                      Icons.notifications_sharp,
                      size: 27.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // context.push(PageRoutes.people);
                // context.pushNamed(PageRoutes.searchRoute);
              },
              icon: Icon(
                Icons.search,
                size: 27.sp,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                // context.push(PageRoutes.userRoomListRoute);
                // context.push(PageRoutes.chatRoute);
              },
              icon: Icon(Icons.mail, size: 27.sp, color: Colors.white),
            )
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            widget.child,
            ValueListenableBuilder<bool>(
              valueListenable: isSheetVisible,
              builder: (context, value, child) {
                if (!value) return const SizedBox.shrink();
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height:
                          animation.value * MediaQuery.of(context).size.height,
                      child:
                          NotificationListener<DraggableScrollableNotification>(
                        onNotification: (notification) {
                          currentExtent = notification.extent;
                          if (currentExtent == minChildSize &&
                              isSheetVisible.value) {
                            toggleSheetVisibility();
                          }
                          return true;
                        },
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.3,
                          minChildSize: minChildSize,
                          maxChildSize: 0.4,
                          builder: (BuildContext context,
                              ScrollController scrollController) {
                            return Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xffF6F0F7),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 12.0, bottom: 6),
                                    height: 5.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          65, 150, 158, 183),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(top: 12),
                                      controller: scrollController,
                                      itemCount: 25,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 15, 12, 15),
                                          margin: const EdgeInsets.only(
                                              bottom: 10, left: 12, right: 12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    184, 150, 158, 183),
                                                offset: Offset(0, 0),
                                                blurRadius: 1,
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Filter $index",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14)),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  width: 15,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      border: Border.all(
                                                          color: const Color
                                                              .fromARGB(186, 29,
                                                              38, 44))),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
