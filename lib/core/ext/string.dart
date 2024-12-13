import 'package:flutter/material.dart';
import 'package:my/core/core.dart';
import 'package:my/core/resources/resources.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';

extension StringExtension on String {
  void toToastError(BuildContext context, {bool isUnitTest = false}) {
    try {
      final message = isEmpty ? "error" : this;

      //dismiss before show toast
      dismissAllToast(showAnim: true);

      showToastWidget(
        Toast(
          bgColor: Theme.of(context).extension<LzyctColors>()!.red,
          icon: Icons.error,
          message: message,
          textColor: Colors.white,
        ),
        dismissOtherToast: true,
        position: ToastPosition.top,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      log.e("error $e");
    }
  }

  String getImgType() {
    final extensionImg = (this).split('.').last.toLowerCase();

    return {
          'jpg': 'jpeg',
          'jpeg': 'jpeg',
          'png': 'png',
        }[extensionImg] ??
        'jpeg';
  }

  void toToastSuccess(BuildContext context) {
    try {
      final message = isEmpty ? "success" : this;

      //dismiss before show toast
      dismissAllToast(showAnim: true);

      // showToast(msg)
      showToastWidget(
        Toast(
          bgColor: Theme.of(context).extension<LzyctColors>()!.green,
          icon: Icons.check_circle,
          message: message,
          textColor: Colors.white,
        ),
        dismissOtherToast: true,
        position: ToastPosition.top,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      log.e("$e");
    }
  }

  void toToastLoading(BuildContext context, {bool isUnitTest = false}) {
    try {
      final message = isEmpty ? "loading" : this;
      //dismiss before show toast
      dismissAllToast(showAnim: true);

      showToastWidget(
        Toast(
          bgColor: Theme.of(context).extension<LzyctColors>()!.pink,
          icon: Icons.info,
          message: message,
          textColor: Colors.white,
        ),
        dismissOtherToast: true,
        position: ToastPosition.top,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      log.e("$e");
    }
  }

  //coverage:ignore-end

  String toStringDateAlt({bool isShort = false, bool isToLocal = true}) {
    try {
      DateTime object;
      if (isToLocal) {
        object = DateTime.parse(this).toLocal();
      } else {
        object = DateTime.parse(this);
      }

      return DateFormat("dd ${isShort ? "MMM" : "MMMM"} yyyy HH:mm", "id")
          .format(object);
    } catch (_) {
      return "-";
    }
  }
}

extension StringExtensions on String? {}
