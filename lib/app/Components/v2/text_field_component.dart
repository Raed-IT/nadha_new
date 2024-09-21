import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TextFieldComponentV2 extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final void Function(String)? onChange;
  final String? label;
  final int? maxLines;

  final bool isMultiple;
  final bool autofocus;
  final bool isDisable;
  final bool isRequired;
  final bool hasSpaseUp;
  final InputDecoration? inputDecoration;

  const TextFieldComponentV2(
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
      this.isRequired = false,
      this.isMultiple = false,
      this.hasSpaseUp = true,
      this.inputDecoration,
      this.maxLines});

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
                  "$label ${isRequired ? '*' : ''}",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
            16.verticalSpace,
            Stack(
              children: [
                SizedBox(
                  height: 54.h,
                  width: Get.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.sp)
                    ),
                    elevation: 8,
                    shadowColor: Colors.black26,
                    margin: EdgeInsets.zero,
                  ),
                ),
                TextFormField(
                  maxLines: isMultiple ? maxLines : 1,
                  minLines: isMultiple ? 4 : null,
                  enabled: isDisable,
                  autofocus: autofocus,
                  onChanged: onChange,
                  keyboardType: keyboardType,
                  validator: validator,
                  controller: controller,
                  style: textStyle ??
                      const TextStyle(fontSize: 15.0, color: Colors.black),
                  obscureText:
                      isPassword ? isShowPass.value : RxBool(false).value,
                  decoration: inputDecoration ??
                      InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: isPassword
                            ? SizedBox(
                                width: 30.w,
                                child: IconButton(
                                  iconSize: 25.sp,
                                  padding: EdgeInsets.zero,
                                  onPressed: () =>
                                      isShowPass.value = !isShowPass.value,
                                  icon: isShowPass.value
                                      ? Icon(FontAwesomeIcons.eye,size: 17.sp,)
                                      : Icon(FontAwesomeIcons.eyeSlash,size: 17.sp,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        hintText: hint,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                      ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
