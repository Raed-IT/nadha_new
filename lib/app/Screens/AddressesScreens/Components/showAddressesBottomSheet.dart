import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/AuthScreens/MainAuthScreen/MainAuthBindnig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

void showAddressesBottomSheet({required BuildContext context}) {
  Get.bottomSheet(
    enableDrag: true,
    elevation: 7,
    isScrollControlled: true,
    SizedBox(
      width: Get.width,
      child: Card(
        child: Obx(
          () => Column(
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
                      onTap: () => Get.toNamed(AppRoutes.addAddress),
                      leading: Icon(Icons.add),
                      title: Text("إضافة عنوان جديد "),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
