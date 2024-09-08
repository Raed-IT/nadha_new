import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/address_model.dart';
import 'package:nadha/app/pages/address_screen/address_controller.dart';
import 'package:nadha/app/pages/components/appbar.dart';
import 'package:nadha/app/them/app_colors.dart';

import 'component/add_addres_dialog.dart';

class AddressScreen extends GetView<AddressScreenController> {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.buildScreen(
      bottomNavigationBar: Obx(() => Visibility(
            visible: Get.find<MainController>().selectedAddress.value != null,
            child: GestureDetector(
              onTap: () => controller.saveOrder(context: context),
              child: Container(
                height: 70.h,
                width: Get.width,
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 20.w,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.sp),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "ارسال الطلب",
                      style:
                          TextStyle(color: AppColors.scaffold, fontSize: 20.sp),
                    ),
                  ),
                ),
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.warning,
        onPressed: () => showAddAddressDialog(),
        child: const Icon(Icons.add),
      ),
      appBar: SliverToBoxAdapter(
        child: AppBarComponent(title: "العناوين الخاصة بي "),
      ),
      widgets: [
        SliverToBoxAdapter(
          child: Obx(
            () => (controller.paginationData.isNotEmpty)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.sp),
                        margin: EdgeInsets.all(5.sp),
                        decoration: BoxDecoration(
                            color: AppColors.dark,
                            borderRadius: BorderRadius.circular(5.sp)),
                        child: const Center(
                          child: Text(
                            'اختر عنوان الطلب من قائمة العناوين الخاصة بك ثم اضغط على إرسال الطلب اسفل الصفحة لإتمام الطلب ',
                            style: TextStyle(
                              color: AppColors.scaffold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Text(
                          "قائمة العناوين الخاصة بي ",
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                : Container(),
          ),
        ),
        SliverToBoxAdapter(
          child: Obx(
            () => (controller.isLoadPagination.value)
                ? Column(
                    children: List.generate(100, (index) => index)
                        .map(
                          (e) => Opacity(
                            opacity: 0.5,
                            child: CardLoading(
                              margin: EdgeInsets.all(10.w),
                              height: 90.h,
                              width: Get.width,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.sp),
                              ),
                            ),
                          ),
                        )
                        .toList()
                        .animate()
                        .scale(
                          duration: const Duration(milliseconds: 200),
                        ),
                  )
                : (controller.paginationData.isNotEmpty)
                    ? Column(
                        children: controller.paginationData
                            .map(
                              (address) => buildCard(address: address),
                            )
                            .toList()
                            .animate()
                            .scale(
                              duration: 300.ms,
                            )
                            .scale(),
                      )
                    : SizedBox(
                        height: 300.h,
                        child: Column(
                          children: [
                            Expanded(
                              child: Lottie.asset(
                                'assets/json/nodata.json',
                              ),
                            ),
                            Text(
                              "اضغط على   +   لإضافة عنوان جديد ",
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ).animate().slide(
                          begin: const Offset(0, 0.3),
                        ),
          ),
        )
      ],
    );
  }

  Widget buildCard({required AddressModel address}) {
    return Obx(
      () => Column(
        children: [
          GestureDetector(
            onTap: () =>
                Get.find<MainController>().selectedAddress.value = address,
            child: SizedBox(
              height: 90.h,
              width: Get.width,
              child: Card(
                color: (Get.find<MainController>().selectedAddress.value?.id ==
                        address.id)
                    ? AppColors.warning
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.sp),
                  ),
                ),
                elevation: 7,
                shadowColor: AppColors.highlight.withOpacity(0.7),
                child: ListTile(
                  title: Text(address.name ?? ''),
                  subtitle: Text(address.address ?? ''),
                  trailing: IconButton(
                    // padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.defaultDialog(
                        title: "حذف العنوان ",
                        content: Column(
                          children: [
                            Text("هل انت متاكد من حذف ${address.name}  ?"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    color: AppColors.danger,
                                    onPressed: () {
                                      Get.back();
                                      controller.deleteAddress(
                                          address: address);
                                    },
                                    child: Text(
                                      "حذف",
                                      style: TextStyle(
                                          color: AppColors.scaffold,
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Expanded(
                                  child: MaterialButton(
                                    color: AppColors.warning,
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      "اغلاق",
                                      style: TextStyle(
                                          color: AppColors.scaffold,
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 20.sp,
                      color: AppColors.danger,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
