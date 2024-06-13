import 'package:delevary/app/Screens/ProfileScreen/ProfileScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:intl/intl.dart';

class TimeComponent extends GetView<ProfileScreenController> {
  const TimeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "اغلاق وفتح المتجر تلقائي",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          10.verticalSpace,
          Obx(() => Row(children: [
            Switch(value: controller.autoClose.value, onChanged: (val) {
              controller.autoClose.value=val;
            }),
            10.horizontalSpace,
            Text("${controller.autoClose.value?'مفعل':'غير مفعل'}")
          ],)),
          10.verticalSpace,
          Text(
            "ساعات عمل المتجر",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          10.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " من  :  ",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => showTimePickerDialog(context, controller),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary)),
                  child: Obx(() => Text(DateFormat("h:mm a", "ar").format(
                      DateFormat("H:mm:ss")
                          .parse('${controller.openAt.value}:00:00')))),
                ),
              ),
              Spacer(),
              Text(
                " إلى :  ",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => showTimePickerDialog(context, controller),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary)),
                  child: Obx(() => Text(DateFormat("h:mm a", "ar").format(
                      DateFormat("H:mm:ss")
                          .parse('${controller.closeAt.value}:00:00')))),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

void showTimePickerDialog(
    BuildContext context, ProfileScreenController controller) async {
  await showDialog(
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "تحديد وقت ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                  ),
                  FromToTimePicker(
                    dismissText: "الغاء",
                    dayText: "صباحا",
                    doneText: "اختيار",
                    nightText: "مسائا",
                    headerText: " اختر الوقت الذي يكون متجرك فيه مفتوح",
                    fromHeadline: "من",
                    toHeadline: "إلى",
                    activeDayNightColor: Theme.of(context).colorScheme.primary,
                    onTab: (from, to) {
                      controller.openAt.value = "${from.hour}";
                      controller.closeAt.value = "${to.hour}";
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ).animate().slideY(begin: 1, curve: Curves.elasticOut),
        ),
      ],
    ),
  );
}
