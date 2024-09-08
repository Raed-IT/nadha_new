import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:nadha/app/route/routs.dart';
import 'package:nadha/app/them/app_colors.dart';

import '../../data/model/product_model.dart';
import 'add_to_cart/add_product_button_component.dart';
import 'clippath/discount_canvas.dart';
import 'image_cache_component.dart';

class ProductsListComponent extends StatefulWidget {
  final Rx<bool> isLoad;
  final RxList<ProductModel> products;
  final bool isFromStore;
  final bool isOffer;
  final Function()? onRefresh;

  const ProductsListComponent({
    super.key,
    this.onRefresh,
    this.isFromStore = false,
    this.isOffer = false,
    required this.products,
    required this.isLoad,
  });

  @override
  State<ProductsListComponent> createState() => _ProductsListComponentState();
}

class _ProductsListComponentState extends State<ProductsListComponent> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (widget.isLoad.value)
          ? Column(
              children: List.generate(100, (index) => index)
                  .map(
                    (e) => Opacity(
                      opacity: 0.5,
                      child: CardLoading(
                        margin: EdgeInsets.all(10.w),
                        height: 140.h,
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
          : (widget.products.isNotEmpty)
              ? Column(
                  children: widget.products
                      .map(
                        (product) => _buildProductCard(
                            productRx: Rx(product),
                            onGetProduct: (prod) {
                              product = prod;
                            }),
                      )
                      .toList()
                      .animate()
                      .slideY(
                        begin: 1,
                        duration: const Duration(milliseconds: 200),
                      ),
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
                        "لايوجد منتجات ",
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ).animate().slide(
                    begin: const Offset(0, 0.3),
                  ),
    );
  }

  Widget _buildProductCard(
      {required Rx<ProductModel> productRx, Function(ProductModel)? onGetProduct}) {



    return Obx(() {
      ProductModel product=productRx.value;
      return  SizedBox(
        height: 180.71.h,
        width: Get.width,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.sp),
            ),
          ),
          elevation: 10,
          shadowColor: AppColors.highlight.withOpacity(0.5),
          child: Padding(
            padding: EdgeInsets.all(5.sp),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.PRODUCT_DETAILS,
                            arguments: {
                              "product": product,
                              "isFromStore": widget.isFromStore,
                              "isOffer": widget.isOffer
                            }),
                        child: Hero(
                          tag:
                          "${widget.isFromStore ? 'store_' : widget.isOffer ? 'offer_' : ''}${product.id}${product.name}",
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.sp),
                            ),
                            child: ImageCacheComponent(
                                height: 113.84.h,
                                width: 125.w,
                                image: "${product.img}"),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 8.0.w),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () => Get.toNamed(
                                              AppRoutes.PRODUCT_DETAILS,
                                              arguments: {
                                                "product": product,
                                                "isFromStore": widget.isFromStore,
                                                "isOffer": widget.isOffer
                                              }),
                                          child: Container(
                                            constraints:
                                            BoxConstraints(maxWidth: 93.w),
                                            child: AutoSizeText(
                                              "${product.name} ",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontFamily: "app"),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '  ${product.unitName ?? ''} ',
                                          style: TextStyle(
                                              color: AppColors.success,
                                              fontSize: 10.sp),
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomPaint(
                                          painter: (product.isDiscount!)
                                              ? DiscountPainter()
                                              : null,
                                          child: Text(
                                            "${product.price}",
                                            style: TextStyle(
                                                fontFamily: "",
                                                fontSize: 12.sp,
                                                color: (!product.isDiscount!)
                                                    ? AppColors.dark
                                                    : AppColors.highlight),
                                          ),
                                        ),
                                        if (product.isDiscount!)
                                          Text(
                                            "  ${product.discount}",
                                            style: TextStyle(
                                                fontFamily: "",
                                                fontSize: 12.sp,
                                                color: AppColors.dark),
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            InkWell(
                              onTap: () => Get.toNamed(AppRoutes.PRODUCT_DETAILS,
                                  arguments: {
                                    "product": product,
                                    "isFromStore": widget.isFromStore,
                                    "isOffer": widget.isOffer
                                  }),
                              child: Container(
                                  padding: EdgeInsets.all(5.sp),
                                  width: Get.width,
                                  child: AutoSizeText(
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 12.sp,
                                          fontFamily: "app"),
                                      maxLines: 2,
                                      '${product.info ?? ''}')),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                height: 30.h,
                                child: ButtonAddProductToCartComponent(
                                  onGetProduct: (neoProduct) {
                                    if (onGetProduct != null) {
                                      onGetProduct(product);
                                    }
                                    Logger().w(neoProduct.toJson());
                                    productRx.value = neoProduct;
                                  },
                                  onRefresh: widget.onRefresh,
                                  product: product,
                                  onDelete: (index) {},
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: GestureDetector(
                      onTap: () {
                        if (!widget.isFromStore) {
                          Get.toNamed(AppRoutes.SHOW_STORE_SCREEN,
                              arguments: {"store": product.store});
                        } else {
                          Fluttertoast.showToast(
                              msg: "انت موجود بالمتجر بالفعل ");
                        }
                      },
                      child: SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.storefront,
                                  size: 15.sp,
                                  color: AppColors.warning,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                AutoSizeText(
                                  product.store?.name ?? '',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: "app",
                                      overflow: TextOverflow.ellipsis),
                                )
                              ],
                            ),
                            Visibility(
                              visible: product.isDiscount!,
                              child: MaterialButton(
                                onPressed: () {
                                  if (widget.isOffer) {
                                    Fluttertoast.showToast(
                                        msg: "انت موجود في صفحة العروض بالفعل ");
                                    return;
                                  }
                                  Get.toNamed(AppRoutes.OFFER_SCREEN);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.certificate,
                                      color: AppColors.danger,
                                      size: 20.sp,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "عرض",
                                      style: TextStyle(color: AppColors.danger),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
