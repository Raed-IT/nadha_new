import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../them/app_colors.dart';

class BuildTextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final void Function(String)? onChange;
  final String? label;

  final bool autofocus;
  final bool isDisable;

  const BuildTextFieldComponent(
      {required this.controller,
      required this.hint,
      this.validator,
      this.label,
      this.autofocus = false,
      this.isPassword = false,
      this.keyboardType,
      this.textStyle,
      this.onChange,
      this.isDisable = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isShowPass = RxBool(true);
    return SizedBox(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null)
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Text(
                  "$label",
                  style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            TextFormField(
              enabled: isDisable,
              autofocus: autofocus,
              onChanged: onChange,
              keyboardType: keyboardType,
              validator: validator,
              controller: controller,
              style: textStyle ??
                  const TextStyle(fontSize: 15.0, color: Colors.black),
              obscureText: isPassword ? isShowPass.value : RxBool(false).value,
              decoration: InputDecoration(
                suffixIcon: isPassword
                    ? SizedBox(
                        width: 30.w,
                        child: IconButton(
                          iconSize: 25.sp,
                          padding: EdgeInsets.zero,
                          onPressed: () => isShowPass.value = !isShowPass.value,
                          icon: isShowPass.value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off_outlined),
                        ),
                      )
                    : const SizedBox(),
                hintText: hint,
                filled: true,
                fillColor: AppColors.fill,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.warning),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
