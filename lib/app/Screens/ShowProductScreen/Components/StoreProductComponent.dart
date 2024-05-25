import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoreProductComponent extends GetView<ShowProductScreenController> {
  const StoreProductComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ()=>Get.toNamed(AppRoutes.showStore,arguments: {"store": controller.product.value?.store}),
        child: BlurryContainer(
          blur: 7,
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.sp,
                backgroundImage: CachedNetworkImageProvider(
                    maxHeight: 600.sp.toInt(),
                    maxWidth: 600.sp.toInt(),
                    "${controller.product.value?.store?.image}"),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      maxLines: 1,
                      "${controller.product.value?.store?.name}  ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
