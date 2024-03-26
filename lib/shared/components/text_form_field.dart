import 'package:chat_gpt_task/shared/style/color.dart';
import 'package:chat_gpt_task/shared/style/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.validate,
    required this.hint,
    this.suffix,
    this.suffixPressed,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?) validate;
  final String hint;
  final ImageProvider? suffix;
  final Function? suffixPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: TextFormField(
        cursorColor: isDark ? AppMainColors.whiteColor : AppMainColors.darkColor,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
          FocusScope.of(context).unfocus;
        },
        selectionControls: MaterialTextSelectionControls(),
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppMainColors.whiteColor,
            ),
        controller: controller,
        validator: validate,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsetsDirectional.symmetric(
            vertical: 18.5,
            horizontal: 24,
          ),
          suffixIcon: InkWell(
            onTap: () {
              suffixPressed!();
            },
            child: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(color: AppMainColors.primaryColor, borderRadius: BorderRadius.circular(4)),
              margin: const EdgeInsetsDirectional.all(8),
              child: ImageIcon(
                suffix,
                color: AppMainColors.whiteColor,
              ),
            ),
          ),
          filled: true,
          fillColor: const Color(0xff484954),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color(0xff10A37F).withOpacity(0.52),
            ),
          ),
          hintText: hint,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color(0xffffffff).withOpacity(0.52),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color(0xffffffff).withOpacity(0.52),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppMainColors.redColor,
            ),
          ),
          errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: AppMainColors.redColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppMainColors.redColor,
            ),
          ),
        ),
      ),
    );
  }
}
