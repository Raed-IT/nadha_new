import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nadha/app/pages/address_screen/address_controller.dart';
import 'package:nadha/app/pages/components/text_field_component.dart';
import 'package:nadha/app/them/app_colors.dart';

Future<void> showAddAddressDialog() async {
  AddressScreenController controller = Get.find();
  Get.defaultDialog(
    title: "اضافة عنوان جديد",
    content: Form(
      key: controller.formKey,
      child: Column(
        children: [
          BuildTextFieldComponent(
              validator: (data) {
                if (data!.isEmpty) {
                  return "ادخل اسم العنوان  ";
                }
                return null;
              },
              controller: controller.nameTextController,
              hint: "اسم العنوان "),
          SizedBox(
            height: 10.h,
          ),
          BuildTextFieldComponent(
              validator: (data) {
                if (data!.isEmpty) {
                  return "ادخل العنوان بالتفصيل";
                }
                return null;
              },
              controller: controller.addressTextController,
              hint: "تفاصيل العنوان"),
          SizedBox(
            height: 10.h,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10.sp),
            ),
            child: Obx(
              () => SizedBox(
                height: 50.h,
                width: Get.width,
                child: (controller.location.value == null)
                    ? MaterialButton(
                        elevation: 0,
                        color: AppColors.fill,
                        onPressed: () => controller.getLocation(),
                        child: Text(
                          "اختيار الموقع الحالي ",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      )
                    : MaterialButton(
                        elevation: 0,
                        color: AppColors.warning,
                        onPressed: () => controller.addAddress(),
                        child: Text(
                          "تم اختيار الموقع انقر للحفظ ",
                          style: TextStyle(
                              color: AppColors.scaffold, fontSize: 15.sp),
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.addAddress(),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: AppColors.warning,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.sp),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "اضافه العنوان",
                        style: TextStyle(
                            color: AppColors.scaffold, fontSize: 15.sp),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    child: Center(
                      child: Text(
                        "الغاء ",
                        style:
                            TextStyle(color: AppColors.danger, fontSize: 15.sp),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
