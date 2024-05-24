import 'package:delevary/app/Components/SlidersComponent.dart';
import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_preview/image_preview.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Data/Models/SliderModel.dart';
import '../../../Services/Api/FavoretService.dart';

class ImageShowProductComponent extends StatefulWidget {
  final GlobalKey productKey;

  ImageShowProductComponent({
    super.key,
    required this.productKey,
  });

  @override
  State<ImageShowProductComponent> createState() =>
      _ImageShowProductComponentState();
}

class _ImageShowProductComponentState extends State<ImageShowProductComponent> {
  final FavoriteService favoriteService = FavoriteService();

  bool isTrregierFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowProductScreenController>(
        tag:
            "show_product${(Get.arguments?.containsKey('product') ?? false) ? Get.arguments['product']?.id : ''}",
        builder: (controller) => Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Hero(
                      tag:
                          "${controller.heroPrefix ?? 'product_image_'}${controller.product.value?.id}",
                      child: Container(
                        key: widget.productKey,
                        child: SliderComponent(
                          onTapItem: (item) {
                            openImagesPage(
                              Navigator.of(context),
                              imgUrls: controller.product.value!.images!
                                  .map((e) => e.url!)
                                  .toList(),
                              heroTags: List.generate(
                                controller.product.value!.images!.length,
                                    (index) =>
                                "${controller.heroPrefix ?? 'product_image_'}${controller.product.value?.id}",
                              ),
                            );
                          },
                          height: 400.h,
                          sliders: controller.product.value!.images!
                              .map((e) => SliderModel(e.id, e.url, ""))
                              .toList(),
                          controller: PageController(),
                          isLoad: RxBool(false),
                        ),
                      ),
                    ),

                    Positioned(
                      right: 10.w,
                      top: 10.h,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Share.share(
                                  '${controller.product.value?.name}\n\n\n${ApiRoute.domin}/products/${controller.product.value?.slug}');
                            },
                            child: SizedBox(
                              width: 45.w,
                              height: 45.h,
                              child: Card(
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.shareNodes,
                                    size: 20.sp,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ).animate().scale(),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                isTrregierFavorite = true;
                              });
                              bool status =
                                  await favoriteService.favoriteTrigger(
                                      product: controller.product.value!,
                                      context: context);
                              setState(() {
                                if (status) {
                                  controller.product.value!.isFavorite =
                                      !controller.product.value!.isFavorite!;
                                }
                                isTrregierFavorite = false;
                              });
                            },
                            child: SizedBox(
                              width: 45.w,
                              height: 45.h,
                              child: Card(
                                child: Center(
                                  child: !isTrregierFavorite
                                      ? Center(
                                          child: Icon(
                                            size: 16.sp,
                                            (controller
                                                    .product.value!.isFavorite!)
                                                ? Icons.favorite
                                                : FontAwesomeIcons.heart,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        )
                                      : SizedBox(
                                          height: 25.sp,
                                          width: 25.sp,
                                          child: Padding(
                                            padding: EdgeInsets.all(5.sp),
                                            child: CircularProgressIndicator(
                                              strokeWidth: 03.sp,
                                            ),
                                          )),
                                ),
                              ),
                            ),
                          ).animate().scale(),
                        ],
                      ),
                    )
                  ],
                );
              },
            ));
  }
}
