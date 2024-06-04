import 'package:delevary/app/Data/Enums/FloorEnum.dart';
import 'package:delevary/app/Screens/CartScreen/CartScreenController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../components/TextFieldComponent.dart';

showConfirmCartDialog(BuildContext context, Function onConfirm,
    CartScreenController cartScreenController) {
  GlobalKey<FormState> form = GlobalKey();
  showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 500),
    barrierDismissible: true,
    transitionBuilder: (context, a1, a2, widget) {
      final curvedValue = Curves.elasticOut.transform(a1.value) - 1.0;
      return Form(
        key: form,
        child: Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 400.sp, 0.0),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (cartScreenController.phoneTextController.text.isEmpty)
                    TextFieldComponent(
                      keyboardType: TextInputType.phone,
                      controller: cartScreenController.phoneTextController,
                      hint: 'رقم الهاتف',
                    ),
                  20.verticalSpace,
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.only(top: 11.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(color: Colors.black12),
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: DropdownButton<String?>(
                      isExpanded: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 8.h),
                      underline: Container(),
                      hint: Text(
                        "اختر رقم الطابق",
                        style: TextStyle(fontSize: 9.sp),
                      ),
                      value: cartScreenController.floor.value,
                      items: FloorEnum.values
                          .map(
                            (e) => DropdownMenuItem<String>(
                              onTap: () {
                                cartScreenController.floor.value = e.name;
                              },
                              value: e.name,
                              child: Text(e.toFloorName()),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {},
                    ),
                  ),
                  10.horizontalSpace,
                  TextFieldComponent(
                    inputDecoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                      hintText: "اسم المستلم",
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 20.sp),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                    ),
                    textStyle: TextStyle(fontSize: 9.sp),
                    validator: (data) {
                      if (data!.isEmpty) {
                        return "اسم المستلم مطلوب ";
                      }
                      return null;
                    },
                    controller:
                        cartScreenController.reciverNameController,
                    hint: '',
                  ),
                  TextFieldComponent(
                    isMultiple: true,
                    controller: cartScreenController.noteTextController,
                    hint: 'ملاحظات الطلب',
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      if (form.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        onConfirm.call();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      width: Get.width,
                      height: 50.h,
                      child: Center(
                        child: Text(
                          "تاكيد الطلب",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ),
                    )
                        .animate(delay: 200.ms)
                        .elevation(
                          duration: 1000.ms,
                          borderRadius: BorderRadius.circular(10.sp),
                        )
                        .scale(duration: 100.ms)
                        .fadeIn(),
                  )
                ],
              ),
            ),
            title: SizedBox(
              height: 10.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      top: -110,
                      right: 0,
                      left: 0,
                      child: Lottie.asset("assets/json/delevary_motor.json",
                          width: 150.sp, height: 150.h))
                ],
              ),
            ),
          ),
        ),
      );
    },
    barrierLabel: "",
    pageBuilder: (context, animation, secondaryAnimation) {
      return Column();
    },
  );
}
