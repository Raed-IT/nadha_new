import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Screens/Store/BalancesScreen/BalancesScreenController.dart';
import 'package:delevary/app/Screens/Store/BalancesScreen/Components/ShowOrderScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TransformsListComponent extends GetView<BalancesScreenController> {
  const TransformsListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Obx(
        () => (controller.isLoadPaginationData.value)
            ? Column(
                children: List.generate(
                  10,
                  (index) => CardLoadingComponent(
                    borderRadius: BorderRadius.circular(10.sp),
                    height: 150.h,
                    width: Get.width,
                  ),
                ).toList(),
              )
            : (controller.paginationData.isNotEmpty)
                ? buildList(context)
                : GestureDetector(
                    onTap: () => controller.getPaginationData(isRefresh: true),
                    child: Container(
                      height: 500.h,
                      child: Center(
                        child: Text("لايوجد بيانات انقر للتحديث"),
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget buildList(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 13.sp,
      overflow: TextOverflow.ellipsis,
    );
    return Column(
      children: controller.paginationData
          .map(
            (transform) => GestureDetector(
              onTap: () {
                if (transform.order != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShowOrderBalanceScreen(
                        order: transform.order!,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  border: Border.all(
                      color: transform.isSender
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary),
                ),
                constraints: BoxConstraints(minHeight: 120.h),
                width: Get.width,
                margin: EdgeInsets.symmetric(vertical: 15.sp),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    BlurryContainer(
                      child: Container(
                        constraints: BoxConstraints(minHeight: 120.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "رقم القيد : ${transform.id}",
                                  style: textStyle,
                                ),
                                Spacer(),
                                Text(
                                  "القيمة : ${transform.amount}",
                                  style: textStyle,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    maxLines: 5,
                                    softWrap: true,
                                    " البيان :   ${transform.info}",
                                    style: textStyle,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "التاريخ :",
                                  style: textStyle,
                                ),
                                Text(
                                  "${transform.createdAt}",
                                  style: textStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Transform.translate(
                        offset: Offset(0, -15.h),
                        child: Container(
                          height: 30.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            border: Border.all(
                              color: transform.isSender
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          child: BlurryContainer(
                            padding: EdgeInsets.zero,
                            borderRadius: BorderRadius.circular(10.sp),
                            child: Center(
                              child: Text(transform.isSender
                                  ? 'فاتورة بيع'
                                  : "امر قبض"),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
