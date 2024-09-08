import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nadha/app/pages/components/text_field_component.dart';
import 'package:nadha/app/them/app_colors.dart';

Future<String> showIfonBootomSheet({required BuildContext context}) async {
  String info = '';
  TextEditingController infoController = TextEditingController();
  await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.sp),
          topLeft: Radius.circular(10.sp),
        ),
      ),
      context: context,
      builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BuildTextFieldComponent(
                    controller: infoController,
                    hint: "ادخل ملاخظة للطلب  (اختياري) ",
                    label: "ادخل ملاخظة للطلب  (اختياري)",
                  ),
                  10.verticalSpace,
                  SizedBox(
                    width: Get.width,
                    height: 50.h,
                    child: MaterialButton(
                      color: AppColors.success,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp)),
                      onPressed: () => Get.back(),
                      child: Text(
                        "اكمل العميلة",
                        style: TextStyle(
                            color: AppColors.scaffold, fontSize: 13.sp),
                      ),
                    ),
                  ),
                  20.verticalSpace
                ],
              ),
            ),
          ));
  return infoController.text;
}
