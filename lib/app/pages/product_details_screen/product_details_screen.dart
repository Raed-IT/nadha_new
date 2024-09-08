import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_preview/image_preview.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/pages/components/drawer_component.dart';
import 'package:nadha/app/pages/product_details_screen/product_details_controller.dart';
import 'package:nadha/app/route/routs.dart';
import 'package:nadha/app/them/app_colors.dart';
import '../components/add_to_cart/add_product_button_component.dart';
import '../components/appbar.dart';
import '../components/bottom_nav_component.dart';
import '../components/clippath/discount_canvas.dart';
import '../components/image_cache_component.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      endDrawer:   DrawerComponent(),
      bottomNavigationBar: BottomNavComponent(),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPinnedToBoxAdapter(child: AppBarComponent()),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: SizedBox(
                width: Get.width,
                height: 270.h,
                child: Hero(
                  tag:
                      "${controller.isFromStore ? 'store_' : controller.isOffer ? 'offer_' : ''}${controller.product.id}${controller.product.name}",
                  child: GestureDetector(
                    onTap: () => openImagesPage(
                      heroTags: [
                        "${controller.product.id}${controller.product.name}"
                      ],
                      Navigator.of(context),
                      imgUrls: ["${controller.product.img}"],
                    ),
                    child: Card(
                      elevation: 8,
                      shadowColor: AppColors.highlight.withOpacity(0.5),
                      margin: EdgeInsets.only(top: 20.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sp),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.sp),
                          ),
                          child: ImageCacheComponent(
                              image: "${controller.product.img}"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Divider(
                  color: AppColors.highlight.withOpacity(0.7),
                  indent: 10.w,
                  endIndent: 10.w,
                  height: 50.h,
                  thickness: 1.8.sp,
                ),
                Card(
                  elevation: 7,
                  shadowColor: AppColors.highlight.withOpacity(0.5),
                  margin: EdgeInsets.only(top: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    width: 250.w,
                    height: 60,
                    child: ButtonAddProductToCartComponent(
                      onDelete: (index) {},
                      product: controller.product,
                    ),
                  ),
                )
                    .animate()
                    .slideY(
                      begin: 1,
                      duration: const Duration(milliseconds: 300),
                    )
                    .scale(),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20.h,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            runAlignment: WrapAlignment.start,
                            alignment: WrapAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: "app",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.sp,
                                      color: AppColors.dark,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            '  ${controller.product.unitName ?? ''} ',
                                        style: TextStyle(
                                            color: AppColors.success,
                                            fontSize: 10.sp),
                                      )
                                    ],
                                    text: "${controller.product.name}"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 30.h,
                        constraints: BoxConstraints(
                          minWidth: 50.w,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.sp),
                          ),
                          border: Border.all(
                              color: AppColors.danger, width: 1.5.sp),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomPaint(
                                painter: (controller.product.isDiscount!)
                                    ? DiscountPainter()
                                    : null,
                                child: Text(
                                  "${controller.product.price}",
                                  style: TextStyle(
                                      fontFamily: "",
                                      fontSize: 12.sp,
                                      color: (!controller.product.isDiscount!)
                                          ? AppColors.dark
                                          : AppColors.highlight),
                                ),
                              ),
                              if (controller.product.isDiscount!)
                                Text(
                                  "  ${controller.product.discount}",
                                  style: TextStyle(
                                      fontFamily: "",
                                      fontSize: 12.sp,
                                      color: AppColors.dark),
                                ),
                            ],
                          ),
                        ),
                      ).animate().slideX(
                            begin: -2,
                            duration: const Duration(milliseconds: 400),
                          )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Text(
                          "${controller.product.info ?? ''}",
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 50.h,
                    thickness: 1.sp,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: GestureDetector(
                      onTap: () {
                        Get.offNamed(
                          AppRoutes.SHOW_STORE_SCREEN,
                          arguments: {"store": controller.product.store},
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.storefront,
                            size: 15.sp,
                            color: AppColors.warning,
                          ),
                          Expanded(
                              child: AutoSizeText(
                            controller.product.store?.name ?? '',
                            maxLines: 1,
                            style: const TextStyle(
                                fontFamily: "app",
                                overflow: TextOverflow.ellipsis),
                          ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
