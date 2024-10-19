import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Services/Api/FavoretService.dart';
import 'package:delevary/app/Services/CartService.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../Data/ApiRoute.dart';

class ProductCardComponent extends StatefulWidget {
  final ProductModel product;
  final Function(GlobalKey kye) onTap;
  final BorderRadius? imageRadius;
  final String? heroTagPrefix;
  final Function(ProductModel product, GlobalKey key) onTapAddProduct;
  final Function(ProductModel product)? onRemoveProductFromFavorite;

  ProductCardComponent(
      {super.key,
      required this.product,
      required this.onTap,
      this.imageRadius,
      this.heroTagPrefix,
      required this.onTapAddProduct,
      this.onRemoveProductFromFavorite});

  @override
  State<ProductCardComponent> createState() => _ProductCardComponentState();
}

class _ProductCardComponentState extends State<ProductCardComponent> {
  final GlobalKey productKey = GlobalKey();

  final FavoriteService favoriteService = FavoriteService();
  bool isTrregierFavorite = false;
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    Get.find<MainController>().cart.listen((p0) {
      if (mounted) setState(() {});
    });
    final GlobalKey productCardKye = GlobalKey();
    return GestureDetector(
      onTap: () {
        if ((widget.product.store?.isOpen ?? false)) {
          widget.onTap(productCardKye);
        }
      },
      child: Container(
        height: 240.h,
        padding: EdgeInsets.only(bottom: 5.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(5.sp),
          border: Border.all(
            width: _cartService.inCart(product: widget.product) ? 3.sp : 0.sp,
            color: _cartService.inCart(product: widget.product)
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary.withOpacity(0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Hero(
                              tag:
                                  "${widget.heroTagPrefix ?? 'product_image_'}${widget.product.id}",
                              child: Container(
                                key: productCardKye,
                                child: ImageCacheComponent(
                                  height: 150.h,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.sp),
                                    topLeft: Radius.circular(5.sp),
                                  ),
                                  image: "${widget.product.image}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       widget.onTapAddProduct(
                      //           widget.product, productCardKye);
                      //     },
                      //     child: SizedBox(
                      //       height: 35.sp,
                      //       width: 35.sp,
                      //       child: Card(
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5.sp),
                      //         ),
                      //         child: Center(
                      //           child: Icon(
                      //             color: Theme.of(context).colorScheme.primary,
                      //             FontAwesomeIcons.plus,
                      //             size: 16.sp,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        top: 0.h,
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              isTrregierFavorite = true;
                            });
                            bool status = await favoriteService.favoriteTrigger(
                                product: widget.product, context: context);
                            setState(() {
                              if (status) {
                                if (widget.product.isFavorite! &&
                                    widget.onRemoveProductFromFavorite !=
                                        null) {
                                  widget.onRemoveProductFromFavorite!(
                                      widget.product);
                                }
                                widget.product.isFavorite =
                                    !widget.product.isFavorite!;
                              }
                              isTrregierFavorite = false;
                            });
                          },
                          child: SizedBox(
                            height: 35.sp,
                            width: 35.sp,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.sp),
                              ),
                              child: !isTrregierFavorite
                                  ? Center(
                                      child: Icon(
                                        size: 16.sp,
                                        (widget.product.isFavorite!)
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
                                      ),),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 33.h,
                        child: GestureDetector(
                          onTap: () {
                            Share.share(
                                '${widget.product.name}\n\n\n${ApiRoute.domin}/products/${widget.product.slug}');
                          },
                          child: SizedBox(
                            height: 35.sp,
                            width: 35.sp,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.sp),
                              ),
                              child: Icon(
                                FontAwesomeIcons.shareNodes,
                                size: 15.sp,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (!(widget.product.store?.isOpen ?? false))
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      height: 150.h,
                      width: Get.width,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5),
                      child: Center(
                        child: Text(
                          "المتجر مغلق",
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   5.verticalSpace,
                    Text(
                      "${widget.product.name}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${widget.product.info}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    BuildPriceProductComponent(
                      product: Rx(widget.product),
                    ),
                    5.verticalSpace,
                    SizedBox(
                      height: 24.h,
                      width: Get.width,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.sp),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          widget.onTapAddProduct(
                              widget.product, productCardKye);
                        },
                        child: Icon(
                          Icons.add,
                          size: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
