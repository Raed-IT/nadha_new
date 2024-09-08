import 'package:card_loading/card_loading.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nadha/app/data/model/points_model.dart';
import 'package:nadha/app/pages/balance_screen/balance_controller.dart';
import 'package:nadha/app/them/app_colors.dart';
import '../components/appbar.dart';
import '../components/bottom_nav_component.dart';

class BalanceScreen extends GetView<BalanceScreenController> {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.buildScreen(
      onRefresh: () async {
        controller.getData();
      },
      extendBody: true,
      bottomNavigationBar: BottomNavComponent(),
      appBar: const SliverPinnedToBoxAdapter(
        child: AppBarComponent(title: "صفحة الرصيد  "),
      ),
      widgets: [
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(() => GestureDetector(
                    onTap: () {
                      controller.setectedItem.value = 0;
                    },
                    child: buildCard(
                        title: 'رصيد النقاط',
                        content: controller.totalPoint.value),
                  )),
              Obx(() => GestureDetector(
                    onTap: () {
                      controller.setectedItem.value = 1;
                    },
                    child: buildCard(
                        title: 'الرصيد',
                        content: controller.totalBalance.value),
                  ))
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Obx(
            () => (controller.isLoadPagination.value)
                ? Column(
                    children: List.generate(100, (index) => index)
                        .map(
                          (e) =>  Opacity(
                            opacity: 0.5,
                            child: CardLoading(
                              margin: EdgeInsets.all(10.w),
                              height: 200.h,
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
                              (item) => builItemdCard(model: item),
                            )
                            .toList()
                            .animate()
                            .slideY(
                              begin: 1,
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
                              "لايوجد عناصر ",
                              style: TextStyle(
                                  fontSize: 22.sp, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ).animate().slide(
                          begin: const Offset(0, 0.3),
                        ),
          ),
        ),
      ],
    );
  }

  Widget builItemdCard({required PointModel model}) {
    return Container(
      constraints: BoxConstraints(minHeight: 100.h),
      width: Get.width,
      child: Card(
        margin: EdgeInsets.all(10.sp),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "القيمة : ${(model.credit == 0) ? model.debit : model.credit}",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "نوع عملية الشحن : ${model.debit! > 0 ? 'شراء' : 'شحن'}",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Visibility(
                visible: model.info != null,
                child: SizedBox(
                  width: Get.width,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      Text(
                        "البيان :",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        " ${model.info}",
                        style: TextStyle(fontSize: 15.sp),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 30.h,
              ),
              Text("${model.createdAt}")
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(
      {required String title,
      required String content,
      void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 150.h,
        width: 150.w,
        child: Card(
          elevation: 7,
          shadowColor: AppColors.highlight.withOpacity(.5),
          margin: EdgeInsets.all(10.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.sp),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.sp),
                    topLeft: Radius.circular(10.sp),
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: AppColors.scaffold,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    content,
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
