import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recharge_buddy/core/theme/app_colors.dart';
import 'package:recharge_buddy/core/theme/typography.dart';

///Common TextFieldWidget that can be used throughout the app
class CommonTextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputType textInputType;
  final String? Function(String?)? validation;
  final bool alignCenter;
  final bool readOnly;
  final bool obsecureText;
  final int maxLength;
  final TextCapitalization textCapitalization;

  const CommonTextFieldWidget({
    super.key,
    required this.labelText,
    this.controller,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.validation,
    this.alignCenter = false,
    this.readOnly = false,
    this.obsecureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength = 25,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      validator: validation,
      keyboardType: textInputType,
      controller: controller,
      textCapitalization: textCapitalization,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      readOnly: readOnly,
      textAlign: alignCenter ? TextAlign.center : TextAlign.start,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Colors.black,
          ),
      decoration: InputDecoration(
        hintText: labelText,
        helperStyle: bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.gray,
            width: 1,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        hintStyle: bodyMedium,
        hintTextDirection: TextDirection.ltr,
      ),
      onChanged: (text) {
        if (kDebugMode) {
          print('Text changed: $text');
        }
        onChanged?.call(text);
      },
    );
  }
}
