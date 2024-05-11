import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Screens/NotificationScreen/NotificationScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NotificationsListComponent extends GetView<NotificationScreenController> {
  const NotificationsListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Expanded(
      child: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            children: [
              if (!controller.isLoadPaginationData.value &&
                  controller.paginationData.isEmpty) ...[
                200.verticalSpace,
                Opacity(
                  opacity: 0.7,
                  child: Lottie.asset(
                    "assets/json/notifications_empty.json",
                    width: 100.w,
                    height: 150.h,
                  ),
                ),
                30.verticalSpace,
                Text(
                  "لا تملك اي إشعارات الان",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                )
              ],
              if (!controller.isLoadPaginationData.value &&
                  controller.paginationData.isNotEmpty)
                ...controller.paginationData
                    .map(
                      (element) => Card(
                        shape: RoundedRectangleBorder(
                          side: (!element.isRead!.value)
                              ? BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.3))
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                        child: ListTile(
                          title: Text("${element.title}"),
                          subtitle: Text("${element.body} "),
                          leading: Icon(
                            Icons.notifications_active_outlined,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              if (controller.isLoadPaginationData.value)
                ...List.generate(20, (index) => index)
                    .map(
                      (e) => CardLoadingComponent(
                        height: 100.h,
                      ),
                    )
                    .toList(),
              LoadMoreComponent(
                isFinished: controller.isFinish,
                isLoad: controller.isLoadMore,
              )
            ],
          )
              .loadMoreAble(
            scrollController: scrollController,
            onLoadMore: () async {
              await controller.loadMore();
            },
          )
              .refreshAbel(
            onRefresh: () async {
              await controller.getFreshData();
            },
          ),
        ),
      ),
    );
  }
}
