import 'package:flutter/material.dart';
import 'package:recharge_buddy/core/theme/typography.dart';

import '../theme/app_colors.dart';

///Common RoundedButton that can be used throughout the app
class CommonRoundedButton extends StatelessWidget {
  final String text;
  final Icon? icon;
  final Color? buttonColor;
  final TextStyle? style;
  final Function() onPressed;
  const CommonRoundedButton(
      {super.key, required this.text, this.icon, this.buttonColor, this.style, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      label: Text(text, style: style ?? bodySmallWhite,textAlign: TextAlign.center,),
      icon: icon,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30), // Adjust the oval shape here
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
            buttonColor ?? AppColors.primary), // Button background color
      ),
    );
  }
}
