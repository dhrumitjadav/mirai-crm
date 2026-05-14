import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObscure;
  final String? Function(String?)? validator;
  final bool isPhoneNumber;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int phoneNumberLength;
  final bool isApplyInputFormatter;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSubmitted;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.isObscure = false,
    this.validator,
    this.isPhoneNumber = false,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.textInputAction,
    this.maxLines = 1,
    this.phoneNumberLength = 10,
    this.isApplyInputFormatter = false,
    this.focusNode,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      readOnly: readOnly,
      showCursor: true,
      focusNode: focusNode,
      maxLines: maxLines,
      obscureText: isObscure,
      inputFormatters: isApplyInputFormatter ? inputFormatters : [],
      maxLength: isPhoneNumber ? phoneNumberLength : null,
      textInputAction: textInputAction ?? TextInputAction.next,
      onTap: onTap,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onEditingComplete: () {
        if (onSubmitted != null) {
          onSubmitted!();
          return;
        }
        final action = textInputAction ?? TextInputAction.next;
        if (action == TextInputAction.next) {
          FocusScope.of(context).nextFocus();
        } else if (action == TextInputAction.previous) {
          FocusScope.of(context).previousFocus();
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      keyboardType: isPhoneNumber ? TextInputType.phone : TextInputType.text,
      validator: validator,
      style: TextStyle(
        fontSize: context.s(14),
        color: CommonColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: context.s(14),
          color: CommonColors.textTertiary,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        counterText: '',

        filled: true,
        fillColor: CommonColors.whiteColor,
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.w(14),
          vertical: context.h(14),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CommonColors.borderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CommonColors.borderDefault),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CommonColors.borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CommonColors.appRedColor, width: 1.5),
        ),
      ),
    );
  }
}
