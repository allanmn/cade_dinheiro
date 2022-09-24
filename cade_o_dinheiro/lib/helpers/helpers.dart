import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Helpers {
  static String currencyFormat(double value) {
    final currency = NumberFormat("#,##0.00", "pt_BR");
    return "R\$ ${currency.format(value)}";
  }

  static confirm({
    required String title,
    required String message,
    required String backText,
    required Color confirmColor,
    required String confirmText,
    required BuildContext context,
  }) {
    return Get.defaultDialog(
      title: title,
      middleText: message,
      confirm: TextButton(
        onPressed: () {
          Get.back(
            result: true,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: confirmColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              confirmText,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back(
            result: false,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.colors.medium,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              backText,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static toast(
      {required String title,
      required String message,
      Color? color,
      Color? backgroundColor}) async {
    // ignore: prefer_conditional_assignment
    if (color == null) {
      color = Colors.white;
    }

    // ignore: prefer_conditional_assignment
    if (backgroundColor == null) {
      backgroundColor = AppTheme.colors.primary;
    }

    if (Get.isSnackbarOpen) return;

    Get.snackbar(title, message,
        colorText: color, backgroundColor: backgroundColor);
  }
}
