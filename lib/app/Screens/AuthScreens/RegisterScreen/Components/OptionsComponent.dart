import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/RegisterScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../Data/Enums/GenderTypeEnum.dart';
import '../../../../Data/Enums/MaritalStatusEnum.dart';

class RegisterOptionsComponent extends GetView<RegisterScreenController> {
  const RegisterOptionsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Obx(
        () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: () => controller.currentWidget.value = 0,
                    icon: const Icon(FontAwesomeIcons.backward),
                  )
                ],
              ),
              Text("اختر نوع ال ــــ",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp)),
              70.verticalSpace,
              Row(
                children: GenderTypeEnum.values
                    .map(
                      (e) => Expanded(
                        child: GestureDetector(
                          onTap: () => controller.gender.value = e,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SizedBox(
                                height: 150.h,
                                width: Get.width,
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      side: controller.gender.value == e
                                          ? BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)
                                          : BorderSide.none),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Text(
                                        e.toGenderName(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                      15.verticalSpace,
                                    ],
                                  ),
                                ).animate().elevation(
                                      begin: 0,
                                      end:
                                          Theme.of(context).cardTheme.elevation,
                                      color: Theme.of(context)
                                          .cardTheme
                                          .shadowColor,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                    ),
                              ),
                              Positioned(
                                top: -50.h,
                                child: SizedBox(
                                  width: Get.width / 2,
                                  child: Lottie.asset(
                                      "assets/json/${e.name}.json"),
                                ),
                              ),
                            ],
                          ),
                        ).animate().slideY(begin: 0.2),
                      ),
                    )
                    .toList(),
              ),
              20.verticalSpace,
              Text(
                "الحالة الإجتماعية",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
              ).animate().slideY(begin: 0.2),
              20.verticalSpace,
              Obx(
                () {
                  int count = 0;
                  return Row(
                    children: MaritalStatusEnum.values.map(
                      (e) {
                        count++;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => controller.maritalStatus.value = e,
                            child: SizedBox(
                              height: 50.h,
                              child: Card(
                                elevation: controller.maritalStatus.value == e
                                    ? 10
                                    : null,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    side: controller.maritalStatus.value == e
                                        ? BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary)
                                        : BorderSide.none),
                                child: Center(
                                  child: Text(
                                    e.toMaritalName(),
                                  ),
                                ),
                              ),
                            ),
                          ).animate().slideY(
                                begin: 0.2,
                                duration: Duration(
                                  milliseconds: 300 + (count * 100),
                                ),
                              ),
                        );
                      },
                    ).toList(),
                  );
                },
              ),
              40.verticalSpace,
              SizedBox(
                width: Get.width,
                height: 60.h,
                child: FilledButton.tonal(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.sp),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () => controller.register(context),
                  child: const Text(
                    "تـسـجـيـل ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ).animate().slideY(
                    begin: 0.2,
                    duration: const Duration(milliseconds: 600),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
