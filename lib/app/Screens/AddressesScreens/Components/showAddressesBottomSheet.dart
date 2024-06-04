import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> showAddressesBottomSheet({required BuildContext context}) async {
  await Get.bottomSheet(
    enableDrag: true,
    elevation: 7,
    isScrollControlled: true,
    SizedBox(
      width: Get.width,
      child: Card(
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Text(
                    "أختر العنوان لتوصيل الطلب ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  ),
                ),
                10.verticalSpace,
                Divider(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ...Get.find<MainController>()
                          .user
                          .value!
                          .addresses!
                          .map(
                            (address) => Container(
                              margin: EdgeInsets.symmetric(vertical: 5.sp),
                              child: ListTile(
                                subtitle: Text("${address.info}"),
                                onTap: () {
                                  Get.find<MainController>()
                                      .selectedAddress
                                      .value = address;
                                },
                                horizontalTitleGap: 20.sp,
                                titleAlignment: ListTileTitleAlignment.center,
                                leading: Get.find<MainController>()
                                        .isSelectedAddress(address: address)
                                    ? Icon(
                                        Icons.check,
                                        size: 25.sp,
                                      )
                                    : 10.horizontalSpace,
                                selected: Get.find<MainController>()
                                        .selectedAddress
                                        .value
                                        ?.id ==
                                    address.id,
                                title: Text("${address.name}"),
                              ),
                            ),
                          )
                          .toList(),
                      ListTile(
                        onTap: () {
                          Get.back();
                          Get.toNamed(AppRoutes.addAddress,
                              arguments: {"fromCart": true});
                        },
                        leading: Icon(Icons.add),
                        title: Text("إضافة عنوان جديد "),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.sp)),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "تــم",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
