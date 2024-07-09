import 'package:flutter/material.dart';
import 'package:recharge_buddy/core/theme/app_colors.dart';
import 'package:recharge_buddy/core/theme/typography.dart';
import 'package:uuid/uuid.dart';

import '../routes/app_routes.dart';

class Utils {
  //function to show a toast message
  static void toast(
    String message,
  ) {
    final context = AppRouter.context;

    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(message, style: bodyMediumWhite),
          ),
        ),
      ),
    );
  }

  //This function generates UUID
  static String generateUUID() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  //Function to perform logical operations based on if the user is verified or not
  static bool isVerifiedUser() {
    return true;
  }
}
