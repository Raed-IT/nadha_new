import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
void deleteAddressDialog(
    {required BuildContext context,
      required AddressModel address,
      required Function(AddressModel oroduct)? onDelete}) {
  showDialog(
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200.h,
          width: Get.width - 100.w,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "حذف عنوان",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                  ),
                  Text("سيتم حذف ${address.name}"),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () => Get.back(),
                          child: Text(
                            "إلغاء",
                            style: TextStyle(
                                color:
                                Theme.of(context).colorScheme.background),
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: MaterialButton(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.sp)),
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () => onDelete!=null?onDelete(address):null,
                          child: Text(
                            "حذف",
                            style: TextStyle(
                                color:
                                Theme.of(context).colorScheme.background),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ).animate().slideY(begin: 1, curve: Curves.elasticOut),
        ),
      ],
    ),
  );
}
