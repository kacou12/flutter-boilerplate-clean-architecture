import 'package:flutter/material.dart';
import 'package:my/core/core.dart';
import 'package:my/core/resources/resources.dart';

extension ContextExtensions on BuildContext {
  double widthInPercent(double percent) {
    final toDouble = percent / 100;

    return MediaQuery.of(this).size.width * toDouble;
  }

  Size get size => MediaQuery.sizeOf(this);

  double get height => size.height;

  double get width => size.width;

  double heightInPercent(double percent) {
    final toDouble = percent / 100;

    return MediaQuery.of(this).size.height * toDouble;
  }

  //Start Loading Dialog
  static late BuildContext ctx;

  Future<void> show() => showDialog(
        context: this,
        barrierDismissible: false,
        builder: (c) {
          ctx = c;

          return PopScope(
            canPop: false,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(c).extension<LzyctColors>()!.background,
                    borderRadius: BorderRadius.circular(Dimens.cornerRadius),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: Dimens.space30),
                  padding: EdgeInsets.all(Dimens.space24),
                  child: const Loading(),
                ),
              ),
            ),
          );
        },
      );

  void dismiss() {
    try {
      Navigator.pop(ctx);
    } catch (_) {}
  }
}
