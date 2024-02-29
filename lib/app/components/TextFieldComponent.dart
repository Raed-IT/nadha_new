import 'package:delevary/app/thems/AppColots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextFieldComponent extends StatelessWidget {
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
  final bool isRequired;

  const TextFieldComponent(
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
      super.key,
      this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    RxBool isShowPass = RxBool(true);
    return SizedBox(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            if (label != null)
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Text(
                  "$label ${isRequired ? '*' : ''}",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
            5.verticalSpace,
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

                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
                focusedBorder: OutlineInputBorder(
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
