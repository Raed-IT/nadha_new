import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Data/Models/SliderModel.dart';
import 'package:delevary/app/Screens/Store/Sliders/SlidersScreen/Componsnts/DeleteDialog.dart';
import 'package:delevary/app/Screens/Store/Sliders/SlidersScreen/SlidersScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreSliderListComponent extends GetView<SlidersStoreScreenController> {
  const StoreSliderListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.isLoadPaginationData.value)
          ? loading()
          : (controller.paginationData.isNotEmpty)
              ? Column(
                  children: controller.paginationData
                      .map(
                        (slid) => buildCardSlid(slid, context),
                      )
                      .toList(),
                )
              : noSlider(),
    );
  }

  Widget buildCardSlid(SliderModel slid, BuildContext context) {
    final RxBool status = RxBool(slid.status!);
    final RxBool isUploading = RxBool(false);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      height: 300.h,
      width: Get.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: BlurryContainer(
        blur: 7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40.h,
              width: Get.width,
              child: Row(
                children: [
                  Obx(
                    () => Row(
                      children: [
                        SizedBox(
                          height: 35.h,
                          child: (!isUploading.value)
                              ? FittedBox(
                                  child: Switch(
                                    value: status.value,
                                    onChanged: (val) async {
                                      isUploading.value = true;
                                      bool state =
                                          await controller.triggerStatus(slid);
                                      if (state) {
                                        status.value = !status.value;
                                        slid.status = status.value;
                                      }
                                      isUploading.value = false;
                                    },
                                  ),
                                )
                              : Lottie.asset("assets/json/loader.json"),
                        ),
                        8.horizontalSpace,
                        Text(
                            "حاله الإعلان ( ${status.value ? 'مفعل' : 'غير مفعل'} )")
                      ],
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => showDeleteSliderDialog(
                      context: context,
                      onDelete: () => controller.deleteSlider(slid, context),
                    ),
                    child: SizedBox(
                      width: 40.sp,
                      height: 40.sp,
                      child: Card(
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.trashCan,
                            size: 15.sp,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ImageCacheComponent(
              width: Get.width,
              borderRadius: BorderRadius.circular(10.sp),
              image: "${slid.image}",
              height: 200.h,
            ),
            GestureDetector(
              onTap: () => launch(
                "${slid.url}",
              ),
              child: SizedBox(
                height: 40.h,
                width: Get.width,
                child: Center(
                  child: AutoSizeText(
                    overflow: TextOverflow.ellipsis,
                    "${slid.url}",
                    maxLines: 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget noSlider() {
    return SizedBox(
      height: 500.h,
      width: Get.width,
      child: const Center(
        child: Text("لايوجد إعلانات"),
      ),
    );
  }

  Widget loading() {
    return Column(
      children: List.generate(20, (index) => index)
          .map(
            (e) => CardLoadingComponent(
              borderRadius: BorderRadius.circular(15.sp),
              height: 250.h,
              width: Get.width,
            ),
          )
          .toList(),
    );
  }
}
